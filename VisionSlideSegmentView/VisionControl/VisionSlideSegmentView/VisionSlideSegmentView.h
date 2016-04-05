//
//  VisionSlideSegmentView.h
//  VisionControls
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VisionSlideSegmentView;

@protocol VisionSlideSegmentViewDelegate <NSObject>
@optional
- (void)visionSlideSegmentView:(VisionSlideSegmentView *)view selectedAtIndex:(NSInteger)index;

@end

@interface VisionSlideSegmentView : UIView

@property (weak, nonatomic) id<VisionSlideSegmentViewDelegate> delegate;
@property (strong,nonatomic) NSMutableArray *dataArray;
/**正常色*/
@property (strong,nonatomic) UIColor *itemNormalColor;
/**選中色*/
@property (strong,nonatomic) UIColor *itemSelectedColor;
/**字體大小，默認systemFontSize*/
@property (assign,nonatomic) CGFloat fontSize;
/**下劃線高度，默認2*/
@property (assign,nonatomic) CGFloat lineHeight;

- (void)selectItemAtIndex:(NSInteger)index;
@end
