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
    self.lineView.frame = CGRectMake(0, 0, 300, 300);
    self.lineView.center = self.view.center;
    
    
//    [[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:@"https://api-market.tradeode.com/kline/EURUSD/1m?count=500"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSArray *dataArray = dataDic[@"data"];
//        NSMutableArray *_dataArray = [NSMutableArray new];
//        for (NSDictionary *dic in dataArray) {
//            NSMutableDictionary *muDic = [NSMutableDictionary new];
//            NSString *l = [NSString stringWithFormat:@"%@",dic[@"l"]];
//            NSString *h = [NSString stringWithFormat:@"%@",dic[@"h"]];
//            NSString *o = [NSString stringWithFormat:@"%@",dic[@"o"]];
//            NSString *c = [NSString stringWithFormat:@"%@",dic[@"c"]];
//            l = [l substringFromIndex:3];
//            h = [h substringFromIndex:3];
//            o = [o substringFromIndex:3];
//            c = [c substringFromIndex:3];
//            [muDic setObject:l forKey:@"l"];
//            [muDic setObject:h forKey:@"h"];
//            [muDic setObject:o forKey:@"o"];
//            [muDic setObject:c forKey:@"c"];
//
//            [_dataArray addObject:muDic];
//        }
////        _dataArray =  [_dataArray subarrayWithRange:NSMakeRange(0, 2)];
//        self.lineView.candleDataArray = _dataArray;
//        [self.lineView reloadData];
//
//    }]resume];
    NSMutableArray *candleDataArray = [NSMutableArray new];
    NSMutableArray *lineDataArray1 = [NSMutableArray new];
    NSMutableArray *lineDataArray2 = [NSMutableArray new];
    NSMutableArray *lineDataArray3 = [NSMutableArray new];
    for (int index = 0; index < 40; index ++) {
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
    self.lineView.lineDataArray = @[lineDataArray1, lineDataArray2, lineDataArray3];
    [self.lineView reloadData];
}



- (CurveLineChart *)lineView {
    if (!_lineView) {
        _lineView = [CurveLineChart new];
    }
    return _lineView;
}

@end
