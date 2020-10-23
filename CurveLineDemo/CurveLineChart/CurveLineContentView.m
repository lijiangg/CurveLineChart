//
//  CurveLineContentView.m
//  CurveLineDemo
//
//  Created by 李江 on 2020/10/22.
//  Copyright © 2020 zhongkebocheng. All rights reserved.
//

#import "CurveLineContentView.h"
#import "CAShapeLayer+curveLine.h"
@implementation CurveLineContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _kColor = [UIColor redColor];
        _lineColorArray = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
        _isOpaque = YES;
    
    }
    return self;
}

- (void)reloadData {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    //x轴位置
    CGFloat xAxisPosition = height;
    if (_maxPercent != 1) {
        xAxisPosition = height * _maxPercent;
    }
    CGFloat countX = 0;
    for (int index = 0; index < _candleDataArray.count; index ++) {
        NSDictionary *dic = _candleDataArray[index];
        double oPercent = [dic[@"o"] doubleValue];
        double cPercent = [dic[@"c"] doubleValue];
        double hPercent = [dic[@"h"] doubleValue];
        double lPercent = [dic[@"l"] doubleValue];
        CAShapeLayer *lLayer = [CAShapeLayer lineLayerWithStrokeWidth:1 color:_kColor];
        UIBezierPath *lPath = [UIBezierPath bezierPath];
        CGFloat x = (_rowWidth + _rowSpace) * index;
        CGFloat ly = 0;
        if (lPercent > 0) {
            ly = xAxisPosition - lPercent * height;
        }else if (lPercent < 0) {
            ly = xAxisPosition + (-lPercent * height);
        }
        [lPath moveToPoint:CGPointMake(x + _rowWidth/2, ly)];
        
        CGFloat oy = 0;
        if (oPercent > 0) {
            oy = xAxisPosition - oPercent * height;
        }else if (oPercent < 0) {
            oy = xAxisPosition + (-oPercent * height);
        }
        
        CGFloat cy = 0;
        if (cPercent > 0) {
            cy = xAxisPosition - cPercent * height;
        }else if (cPercent < 0) {
            cy = xAxisPosition + (-cPercent * height);
        }
        
        CGFloat lmy = 0;
        CGFloat hmy = 0;
        if (oPercent > cPercent) {
            lmy = cy;
            hmy = oy;
        }else {
            lmy = oy;
            hmy = cy;
        }
        
        [lPath addLineToPoint:CGPointMake(x + _rowWidth/2, lmy)];
        lLayer.path = lPath.CGPath;
        
        CAShapeLayer *rLayer = [CAShapeLayer rectLayerWithcolor:_kColor];
        rLayer.frame = CGRectMake(x, hmy, _rowWidth, lmy - hmy);
        
        
        CGFloat hy = 0;
        if (hPercent > 0) {
            hy = xAxisPosition - hPercent * height;
        }else if (hPercent < 0) {
            hy = xAxisPosition + (-hPercent * height);
        }
        CAShapeLayer *hLayer = [CAShapeLayer lineLayerWithStrokeWidth:1 color:_kColor];
        UIBezierPath *hPath = [UIBezierPath bezierPath];
        [hPath moveToPoint:CGPointMake(x + _rowWidth/2, hmy)];
        [hPath addLineToPoint:CGPointMake(x + _rowWidth/2, hy)];
        hLayer.path = hPath.CGPath;
        
        [self.layer addSublayer:lLayer];
        [self.layer addSublayer:rLayer];
        [self.layer addSublayer:hLayer];
        
        //累积
        countX += (_rowWidth + _rowSpace);
    }
    
    for (int i = 0; i < _lineDataArray.count; i ++) {
        NSArray *rowArray = _lineDataArray[i];
        countX = _rowWidth/2;
        CAShapeLayer *lineLayer = [CAShapeLayer lineLayerWithStrokeWidth:1 color:_lineColorArray[i]];
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint lastPoint = CGPointZero;
        for (int j = 0; j < rowArray.count; j ++) {
            double percent = [rowArray[j] doubleValue];
            CGFloat x = countX;
            CGFloat y = 0;
            if (percent > 0) {
                y = xAxisPosition - percent * height;
            }else if (percent < 0) {
                y = xAxisPosition + (-percent * height);
            }
            if (j == 0) {
                lastPoint = CGPointMake(x, y);
                [path moveToPoint:lastPoint];
            }else {
                CGFloat centerX = (lastPoint.x + x)/2;
                [path addCurveToPoint:CGPointMake(x, y) controlPoint1:CGPointMake(centerX, lastPoint.y) controlPoint2:CGPointMake(centerX, y)];
                lastPoint = CGPointMake(x, y);
            }
            lineLayer.path = path.CGPath;
            [self.layer addSublayer:lineLayer];
            //累积
            countX += (_rowWidth + _rowSpace);
        }
    }
}




@end
