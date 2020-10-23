//
//  CurveLineChartViewModel.m
//  CurveLineDemo
//
//  Created by 李江 on 2020/10/22.
//  Copyright © 2020 zhongkebocheng. All rights reserved.
//

#import "CurveLineChartViewModel.h"
@interface CurveLineChartViewModel ()

@property (strong, nonatomic) NSOperationQueue *dataQueue;
@end
@implementation CurveLineChartViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataQueue = [NSOperationQueue new];
    }
    return self;
}

- (void)processDataWithCandleDataArray:(NSArray *)candleDataArray lineDataArray:(NSArray *)lineDataArray success:(SuccessBlock)success {
   NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(processData:) object:@{
       @"candleDataArray":candleDataArray,
       @"lineDataArray":lineDataArray,
       @"success":success
   }];
   [_dataQueue addOperation:operation];
}



- (void)processData:(NSDictionary *)dictionary {
    NSArray *candleDataArray = dictionary[@"candleDataArray"];
    NSArray *lineDataArray = dictionary[@"lineDataArray"];
    SuccessBlock success = dictionary[@"success"];
    
    //求最大值
    __block double maxValue = 0;
    __block double minValue = 0;
    for (int i = 0; i < candleDataArray.count; i ++ ) {
        NSDictionary *dic = candleDataArray[i];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            double data = [obj doubleValue];
            if (data > maxValue) {
                maxValue = data;
            }
            if (data < minValue) {
                minValue = data;
            }
        }];
    }
    
    for (int i = 0; i < lineDataArray.count; i ++ ) {
        NSArray *array = lineDataArray[i];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            double data = [obj doubleValue];
            if (data > maxValue) {
                maxValue = data;
            }
            if (data < minValue) {
                minValue = data;
            }
        }];
    }
    
    //计算maxPercent
    double maxPercent = 1;
    if (maxValue > 0) {
        if (minValue < 0) {
            maxPercent = maxValue/(maxValue - minValue);
        }else if(minValue > 0) {
            
        }else {
            
        }
    }else if (maxValue < 0) {
        if (minValue < 0) {
            maxPercent = 0;
        }else if(minValue > 0) {
            //不会出现
        }else {
            //不会出现
        }
    }
    _maxPercent = maxPercent;
    
    NSMutableArray *candleArray = [NSMutableArray new];
    for (int index = 0; index < candleDataArray.count; index ++) {
        NSDictionary *dic = candleDataArray[index];
        double oData = [dic[@"o"] doubleValue];
        double cData = [dic[@"c"] doubleValue];
        double hData = [dic[@"h"] doubleValue];
        double lData = [dic[@"l"] doubleValue];
        double oPercent = 0;
        if (oData > 0) {
            oPercent = oData/maxValue;
        }else if (oData < 0) {
            oPercent = -oData/minValue;
        }
        double cPercent = 0;
        if (cData > 0) {
            cPercent = cData/maxValue;
        }else if (cData < 0) {
            cPercent = -cData/minValue;
        }
        double hPercent = 0;
        if (hData > 0) {
            hPercent = hData/maxValue;
        }else if (hData < 0) {
            hPercent = -hData/minValue;
        }
        double lPercent = 0;
        if (lData > 0) {
            lPercent = lData/maxValue;
        }else if (lData < 0) {
            lPercent = -lData/minValue;
        }
        [candleArray addObject:@{
            @"o":@(oPercent),
            @"c":@(cPercent),
            @"h":@(hPercent),
            @"l":@(lPercent)
        }];
    }
    _candleDataArray = candleArray;
    
    
    NSMutableArray *lineArray = [NSMutableArray new];
    [lineDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        NSArray *rowArray = obj;
        NSMutableArray *rowLineArray = [NSMutableArray new];
        [rowArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger j, BOOL * _Nonnull stop) {
            double data = [obj doubleValue];
            double percent = 0;
            if (data > 0) {
                percent = data/maxValue;
            }else if (data < 0) {
                percent = -data/minValue;
            }
            [rowLineArray addObject:@(percent)];
        }];
        [lineArray addObject:rowLineArray];
    }];
    _lineDataArray = lineArray;
    
    [[NSOperationQueue mainQueue] addOperation:[NSBlockOperation blockOperationWithBlock:^{
        success();
    }]];
}



@end
