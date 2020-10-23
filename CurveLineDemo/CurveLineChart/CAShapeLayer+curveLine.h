//
//  CAShapeLayer+curveLine.h
//  CurveLineDemo
//
//  Created by 李江 on 2020/10/22.
//  Copyright © 2020 zhongkebocheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAShapeLayer (curveLine)
+ (CAShapeLayer *)lineLayerWithStrokeWidth:(CGFloat)width color:(UIColor *)color;

+ (CAShapeLayer *)rectLayerWithcolor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
