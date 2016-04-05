//
//  VisionSlideSegmentViewDemoController.m
//  VisionControls
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionSlideSegmentViewDemoController.h"
#import "VisionSlideSegmentView.h"

@interface VisionSlideSegmentViewDemoController ()<VisionSlideSegmentViewDelegate>

@end

@implementation VisionSlideSegmentViewDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    self.view.backgroundColor = [UIColor whiteColor];
    //custom paras
    CGFloat width = 200;
    CGFloat height = 40;
    CGFloat leftMargin = self.view.center.x - width / 2;
    CGFloat topMargin = 100;
    NSMutableArray *dataArray = [@[@"First",@"Item",@"Product",@"Apple",@"Fruit",@"Color"] mutableCopy];
    //add slideSegmentView
    //如果該組件是ViewController下第一個子視圖，額外加一個UIView或禁用automaticallyAdjustsScrollViewInsets屬性否則內容會產生偏移.
    //Add a new UIView or set automaticallyAdjustsScrollViewInsets to NO if imageScroller would be the first child of viewController,otherwise contents in scroller will get an offset on Y axis
    [self.view addSubview:[UIView new]];//self.automaticallyAdjustsScrollViewInsets = NO;
    VisionSlideSegmentView *segment = [[VisionSlideSegmentView alloc] initWithFrame:CGRectMake(leftMargin, topMargin, width, height)];
    segment.dataArray = dataArray;
    segment.delegate = self;
    [self.view addSubview:segment];
    //see VisionSlideSegmentView.h to get more methods & properties
    
    //properties
    VisionSlideSegmentView *segment_pp = [[VisionSlideSegmentView alloc] initWithFrame:CGRectMake(leftMargin, topMargin + 60, width, height)];
    segment_pp.dataArray = dataArray;
    segment_pp.delegate = self;
    segment_pp.itemNormalColor = [UIColor blueColor];
    segment_pp.itemSelectedColor = [UIColor blackColor];
    segment_pp.lineHeight = 4;
    segment_pp.fontSize = 16;
    [self.view addSubview:segment_pp];
    
    //automatically disable scroll when items' length is less than view width
    VisionSlideSegmentView *segment_auto = [[VisionSlideSegmentView alloc] initWithFrame:CGRectMake(leftMargin, topMargin + 120, width, height)];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)];
    segment_auto.dataArray = [[dataArray objectsAtIndexes:indexSet] mutableCopy];
    segment_auto.delegate = self;
    [self.view addSubview:segment_auto];
    
    //descriptions
    NSArray *descriptionArray = @[@"Default",@"Custom",@"AutoDisableScroll"];
    for (NSInteger i = 0; i < descriptionArray.count; i++) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:(CGRectMake(5, i == 0 ? topMargin + 15 : topMargin + i * 70, leftMargin - 5, 20))];
        lbl.font = [UIFont systemFontOfSize:9];
        lbl.textColor = [UIColor blueColor];
        lbl.text = [NSString stringWithFormat:@"%@:", descriptionArray[i]];
        [self.view addSubview:lbl];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - delegate
- (void)visionSlideSegmentView:(VisionSlideSegmentView *)view selectedAtIndex:(NSInteger)index{
    NSLog(@"You selected index:%zi",index);
}

@end
