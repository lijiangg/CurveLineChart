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
    __block double minValue = MAXFLOAT;
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
    
    
    NSMutableArray *candleArray = [NSMutableArray new];
    for (int index = 0; index < candleDataArray.count; index ++) {
        NSDictionary *dic = candleDataArray[index];
        double oData = [dic[@"o"] floatValue];
        double cData = [dic[@"c"] floatValue];
        double hData = [dic[@"h"] floatValue];
        double lData = [dic[@"l"] floatValue];
        double oPercent = 0;
        double cPercent = 0;
        double hPercent = 0;
        double lPercent = 0;
        if (maxValue == minValue) {
            oPercent = 1;
            cPercent = 1;
            hPercent = 1;
            lPercent = 1;
        }
        oPercent = (oData - minValue)/(maxValue - minValue);
        cPercent = (cData - minValue)/(maxValue - minValue);
        hPercent = (hData - minValue)/(maxValue - minValue);
        lPercent = (lData - minValue)/(maxValue - minValue);
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
            percent = (data - minValue)/(maxValue - minValue);
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
