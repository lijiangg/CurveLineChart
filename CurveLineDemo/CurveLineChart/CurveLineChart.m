//
//  CurveLineView.m
//  CurveLineDemo
//
//  Created by 李江 on 2020/10/22.
//  Copyright © 2020 zhongkebocheng. All rights reserved.
//

#import "CurveLineChart.h"
#import "CurveLineChartViewModel.h"
#import "CurveLineContentView.h"
@interface CurveLineChart ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) CurveLineContentView *contentView;
@property (strong, nonatomic) CAShapeLayer *lineLayer;

@property (strong, nonatomic) NSLayoutConstraint *contentWidthConstraint;
@property (copy, nonatomic) CurveLineChartViewModel *viewModel;
@end
@implementation CurveLineChart

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)reloadData {
    //刷新数据
    __weak typeof(self) weakSelf = self;
    [_viewModel processDataWithCandleDataArray:_candleDataArray lineDataArray:_lineDataArray success:^{
        CGFloat contentWidth = weakSelf.rowWidth * weakSelf.viewModel.candleDataArray.count + (weakSelf.viewModel.candleDataArray.count - 1) * weakSelf.rowSpace;
        //更新内容大小
        weakSelf.scrollView.contentSize = CGSizeMake(contentWidth, 0);
        //更新约束
        weakSelf.contentWidthConstraint.constant = contentWidth;
        [weakSelf.contentView layoutIfNeeded];
        //刷新内容
        weakSelf.contentView.candleDataArray = weakSelf.viewModel.candleDataArray;
        weakSelf.contentView.lineDataArray = weakSelf.viewModel.lineDataArray;
        weakSelf.contentView.maxPercent = weakSelf.viewModel.maxPercent;
        weakSelf.contentView.rowWidth = weakSelf.rowWidth;
        weakSelf.contentView.rowSpace = weakSelf.rowSpace;
        [weakSelf.contentView reloadData];
    }];
   
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialData];
        [self initialSubview];
        [self layoutSubview];
    }
    return self;
}

- (void)initialData {
    _rowWidth = 10;
    _rowSpace = 5;
    _viewModel = [CurveLineChartViewModel new];
    _contentEdgeInsets = UIEdgeInsetsMake(0, 20, 20, 0);
    
}

- (void)initialSubview {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
}

- (void)layoutSubview {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:_contentEdgeInsets.left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-_contentEdgeInsets.right]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1 constant:_contentEdgeInsets.top]];
    _contentWidthConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
    [self.scrollView addConstraint:_contentWidthConstraint];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeHeight multiplier:1 constant:- (_contentEdgeInsets.top + _contentEdgeInsets.bottom)]];
    
}


- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [CAShapeLayer new];
        _lineLayer.fillColor = [UIColor clearColor].CGColor;
        _lineLayer.strokeColor = [UIColor redColor].CGColor;
        _lineLayer.lineWidth = 2;
    }
    return _lineLayer;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _scrollView;
}

- (CurveLineContentView *)contentView {
    if (!_contentView) {
        _contentView = [CurveLineContentView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentView;
}




@end
