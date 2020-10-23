//
//  CAShapeLayer+curveLine.m
//  CurveLineDemo
//
//  Created by 李江 on 2020/10/22.
//  Copyright © 2020 zhongkebocheng. All rights reserved.
//

#import "CAShapeLayer+curveLine.h"


@implementation CAShapeLayer (curveLine)

+ (CAShapeLayer *)lineLayerWithStrokeWidth:(CGFloat)width color:(UIColor *)color {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = width;
    layer.strokeColor = color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.backgroundColor = [UIColor clearColor].CGColor;
    return layer;
}

+ (CAShapeLayer *)rectLayerWithcolor:(UIColor *)color {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = color.CGColor;
    layer.backgroundColor = color.CGColor;
    return layer;
}



@end
