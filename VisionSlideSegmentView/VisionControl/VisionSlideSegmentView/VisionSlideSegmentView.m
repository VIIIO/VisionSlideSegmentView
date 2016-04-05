//
//  VisionSlideSegmentView.m
//  VisionControls
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionSlideSegmentView.h"

#define visionSlideSegmentViewItemTagSeed 100
@interface VisionSlideSegmentView ()<UIScrollViewDelegate>

@property (strong,nonatomic) NSMutableArray *itemArray;
@property (strong,nonatomic) UIView *lineView;
@property (strong,nonatomic) UIScrollView *scrollView;
@end

@implementation VisionSlideSegmentView
- (instancetype)init{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self setUp];
    }
    return self;
}
- (void)setUp{
    //initialization
    _dataArray = [[NSMutableArray alloc] init];
    _itemArray = [[NSMutableArray alloc] init];
    _itemNormalColor = [UIColor lightGrayColor];
    _itemSelectedColor = [UIColor redColor];
    _fontSize = [UIFont systemFontSize];
    _lineHeight = 2;
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
}


#pragma mark - setter
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    if (dataArray && dataArray.count > 0) {
        //remove all exist items
        for (NSInteger i = self.itemArray.count - 1; i >= 0; i--) {
            UIButton *_btn = self.itemArray[i];
            [_btn removeFromSuperview];
        }
        //calc item width
        CGFloat no_width = self.frame.size.width / dataArray.count;
        if ([self.subviews indexOfObject:_scrollView] == NSNotFound) {
            [self addSubview:_scrollView];
        }
        CGFloat no_margin = 5;
        CGFloat no_dynamicX = 0;
        CGFloat no_firstItemWidth = 0;//decide default line width
        //recreate all items
        for (NSInteger i = 0; i < dataArray.count; i++) {
            UIButton *_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            _btn.tag = visionSlideSegmentViewItemTagSeed + i;
            _btn.frame = CGRectMake(no_margin + no_dynamicX, no_margin , no_width, self.bounds.size.height);
            _btn.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
            [_btn setBackgroundColor:[UIColor clearColor]];
            [_btn setTitle:dataArray[i] forState:UIControlStateNormal];
            [_btn setTitleColor:self.itemNormalColor forState:UIControlStateNormal];
            [_btn setTitleColor:self.itemSelectedColor forState:UIControlStateSelected];
            [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            _btn.selected = i == 0;//select first item
            [self.scrollView addSubview:_btn];
            [self.itemArray addObject:_btn];
            
            [_btn sizeToFit];
            if (i == 0) {
                no_firstItemWidth = _btn.frame.size.width;
            }
            no_dynamicX = _btn.frame.origin.x + _btn.frame.size.width + no_margin;
        }
        //create bottom line
        if (!self.lineView) {
            self.lineView = [[UIView alloc] initWithFrame:(CGRectMake(no_margin, self.bounds.size.height - self.lineHeight , no_firstItemWidth, self.lineHeight))];
            self.lineView.backgroundColor = self.itemSelectedColor;
            [self.scrollView addSubview:self.lineView];
        }else{
            //reset line position & width
            self.lineView.frame = CGRectMake(no_margin, self.bounds.size.height - self.lineHeight , no_firstItemWidth, self.lineHeight);
        }
        //scrollView settings
        _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _scrollView.contentSize = CGSizeMake(no_dynamicX, self.bounds.size.height);// CGSizeMake(no_width * dataArray.count,self.bounds.size.height);
        _scrollView.scrollEnabled = no_dynamicX > self.frame.size.width;//no_width * dataArray.count > self.frame.size.width;
    }
}

- (void)setItemNormalColor:(UIColor *)itemNormalColor{
    _itemNormalColor = itemNormalColor;
    if (itemNormalColor) {
        for (UIButton *_btn in self.itemArray) {
            [_btn setTitleColor:itemNormalColor forState:(UIControlStateNormal)];
        }
    }
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor{
    _itemSelectedColor = itemSelectedColor;
    if (itemSelectedColor) {
        self.lineView.backgroundColor = itemSelectedColor;
        for (UIButton *_btn in self.itemArray) {
            [_btn setTitleColor:itemSelectedColor forState:(UIControlStateSelected)];
        }
    }
}

- (void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    if (fontSize && fontSize > 0) {
        for (UIButton *_btn in self.itemArray) {
            _btn.titleLabel.font = _btn.selected ? [UIFont systemFontOfSize:self.fontSize + 1] : [UIFont systemFontOfSize:self.fontSize];
            [_btn sizeToFit];
        }
    }
}

- (void)setLineHeight:(CGFloat)lineHeight{
    _lineHeight = lineHeight;
    if (lineHeight && lineHeight > 0) {
        CGRect frame = self.lineView.frame;
        frame.size.height = lineHeight;
        frame.origin.y = self.bounds.size.height - self.lineHeight;
        self.lineView.frame = frame;
    }
}
#pragma mark - scrollView delegate

#pragma mark - methods
- (void)btnClicked:(UIButton *)sender{
    CGRect frame = self.lineView.frame;
    CGFloat senderX = sender.frame.origin.x;
    CGFloat senderWidth = sender.frame.size.width;
    frame.origin.x = senderX;
    frame.size.width = senderWidth;
    //if button is not visible after animation,scroll to button
    CGFloat offsetX = self.scrollView.contentOffset.x;
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    if (offsetX > senderX || (offsetX + scrollWidth) < (senderX + senderWidth)) {
        CGFloat offsetXAfterAnimation = sender.center.x - (scrollWidth / 2);
        offsetXAfterAnimation = offsetXAfterAnimation < 0 ? 0 :
        offsetXAfterAnimation > self.scrollView.contentSize.width - scrollWidth ? self.scrollView.contentSize.width - scrollWidth :
        offsetXAfterAnimation;
        [self.scrollView setContentOffset:(CGPointMake(offsetXAfterAnimation, 0)) animated:YES];
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        weakSelf.lineView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    //button settings
    for (UIButton *_btn in self.itemArray) {
        BOOL isSelectedBefore = _btn.selected;
        _btn.selected = [sender isEqual:_btn];
        //change fontSize
        _btn.titleLabel.font = _btn.selected ? [UIFont systemFontOfSize:self.fontSize + 1] : [UIFont systemFontOfSize:self.fontSize];
        [_btn sizeToFit];
        //fix offset
        CGRect frame = _btn.frame;
        frame.origin.y = _btn.selected ? frame.origin.y - 1 ://set position of button which is being selected
        isSelectedBefore ? frame.origin.y + 1 ://recover position of button which is losing focus
        frame.origin.y;//normal buttons
        _btn.frame = frame;
    }
    if ([self.delegate respondsToSelector:@selector(visionSlideSegmentView:selectedAtIndex:)]) {
        [self.delegate visionSlideSegmentView:self selectedAtIndex:sender.tag - visionSlideSegmentViewItemTagSeed];
    }
}

- (void)selectItemAtIndex:(NSInteger)index{
    if (self.itemArray.count > index) {
        [self btnClicked:self.itemArray[index]];
    }
}
@end
