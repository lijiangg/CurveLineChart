//
//  ViewController.m
//  CurveLineDemo
//
//  Created by 李江 on 2020/10/22.
//  Copyright © 2020 zhongkebocheng. All rights reserved.
//

#import "ViewController.h"
#import "CurveLineChart.h"
@interface ViewController ()

@property (strong, nonatomic) CurveLineChart *lineView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.lineView];
    self.lineView.frame = CGRectMake(0, 0, 400, 400);
    self.lineView.center = self.view.center;
//    self.lineView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
//    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:@"https://api-market.tradeode.com/kline/EURUSD/1m?count=500"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSArray *dataArray = dataDic[@"data"];
//        NSMutableArray *_dataArray = [NSMutableArray new];
//        NSMutableArray *_lineDataArray = [NSMutableArray new];
//        for (NSDictionary *dic in dataArray) {
//            NSMutableDictionary *muDic = [NSMutableDictionary new];
//            NSString *l = [NSString stringWithFormat:@"%@",dic[@"l"]];
//            NSString *h = [NSString stringWithFormat:@"%@",dic[@"h"]];
//            NSString *o = [NSString stringWithFormat:@"%@",dic[@"o"]];
//            NSString *c = [NSString stringWithFormat:@"%@",dic[@"c"]];
//
//            [muDic setObject:l forKey:@"l"];
//            [muDic setObject:h forKey:@"h"];
//            [muDic setObject:o forKey:@"o"];
//            [muDic setObject:c forKey:@"c"];
//
//            [_dataArray addObject:muDic];
//        }
//        for (int index = 0; index < 1; index ++) {
//            NSMutableArray *array1 = [NSMutableArray new];
//            NSMutableArray *array2 = [NSMutableArray new];
//            NSMutableArray *array3 = [NSMutableArray new];
//            [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSDictionary *dictionary = obj;
//                CGFloat o = [dictionary[@"o"] floatValue];
//                CGFloat c = [dictionary[@"c"] floatValue];
//                CGFloat l = [dictionary[@"l"] floatValue];
//                CGFloat h = [dictionary[@"h"] floatValue];
//                CGFloat average = (o + c)/2;
//                [array1 addObject:@(average)];
//                [array2 addObject:@(l)];
//                [array3 addObject:@(h)];
//            }];
////            [_lineDataArray addObject:array1];
////            [_lineDataArray addObject:array2];
////            [_lineDataArray addObject:array3];
//        }
//
////        _dataArray =  [_dataArray subarrayWithRange:NSMakeRange(0, 2)];
//        self.lineView.candleDataArray = _dataArray;
//        self.lineView.lineDataArray = _lineDataArray;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.lineView reloadData];
//        });
//
//    }]resume];
    NSMutableArray *candleDataArray = [NSMutableArray new];
    NSMutableArray *lineDataArray1 = [NSMutableArray new];
    NSMutableArray *lineDataArray2 = [NSMutableArray new];
    NSMutableArray *lineDataArray3 = [NSMutableArray new];
    for (int index = 0; index < 100; index ++) {
        [candleDataArray addObject:@{
            @"l":@(arc4random()%1000),
            @"h":@(arc4random()%1000 + 532 + 100),
            @"o":@(arc4random()%1000 + 532),
            @"c":@(arc4random()%1000 + 532 + 50),
        }];
        [lineDataArray1 addObject:@(arc4random()%1000 + 532 + 100)];
        [lineDataArray2 addObject:@(arc4random()%1000 + 532 + 100)];
        [lineDataArray3 addObject:@(arc4random()%1000 + 532 + 100)];
    };
    self.lineView.candleDataArray = candleDataArray;
    self.lineView.lineDataArray = @[lineDataArray1, lineDataArray2];
    [self.lineView reloadData];
}



- (CurveLineChart *)lineView {
    if (!_lineView) {
        _lineView = [CurveLineChart new];
    }
    return _lineView;
}

@end
