//
//  CurveLineChartViewModel.h
//  CurveLineDemo
//
//  Created by 李江 on 2020/10/22.
//  Copyright © 2020 zhongkebocheng. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
typedef void(^SuccessBlock)(void);
@interface CurveLineChartViewModel : NSObject

@property (copy, nonatomic) NSArray *candleDataArray;
@property (copy, nonatomic) NSArray *lineDataArray;
@property (assign, nonatomic) double maxPercent;

- (void)processDataWithCandleDataArray:(NSArray *)candleDataArray lineDataArray:(NSArray *)lineDataArray success:(SuccessBlock)success;

@end

NS_ASSUME_NONNULL_END
