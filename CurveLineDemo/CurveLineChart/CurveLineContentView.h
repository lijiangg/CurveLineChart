//
//  CurveLineContentView.h
//  CurveLineDemo
//
//  Created by 李江 on 2020/10/22.
//  Copyright © 2020 zhongkebocheng. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CurveLineContentView : UIView

//默认 1.0
@property (assign, nonatomic) double maxPercent;
@property (assign, nonatomic) CGFloat rowWidth;
@property (assign, nonatomic) CGFloat rowSpace;
@property (strong, nonatomic) UIColor *kColor;
@property (copy, nonatomic) NSArray *lineColorArray;
@property (assign, nonatomic) BOOL isOpaque;

@property (copy, nonatomic) NSArray *candleDataArray;
@property (copy, nonatomic) NSArray *lineDataArray;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
