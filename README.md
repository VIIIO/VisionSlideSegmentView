VisionSlideSegmentView
=====
* Advanced segmentControl which supports infinite items. Scrollable horizontally only. You could replace `UISegmentControl` with VisionSlideSegmentView directly.
* 可在水平方向上无限延长的分段选择器，可直接替代`UISegmentControl`使用。

### Screenshots
None.

### Contents
## Installation 安装

* Just drag `VisionControl` folder into your project
* 将`VisionControl`文件夹拖入你的項目

### 在你需要使用控件的文件中导入头文件:
```objective-c
#import "VisionSlideSegmentView.h"
```
## Usage 使用方法
```objective-c
VisionSlideSegmentView *segment = [[VisionSlideSegmentView alloc] 
                                      initWithFrame:CGRectMake(0, 0, 200, 40)];
segment.dataArray = dataArray;
segment.delegate = self;
[self.view addSubview:segment];


#pragma mark - delegate
- (void)visionSlideSegmentView:(VisionSlideSegmentView *)view selectedAtIndex:(NSInteger)index{
    NSLog(@"Index:%zi",index);
}

```

## Features 特性
* Support infinite items</br>
* `SizeToFit` automatically</br>
* Enable scroll automatically</br>
* 无限分段数</br>
* 自适应文本长度</br>
* 自动启用/禁用水平滚动</br>

## Requirements 要求
* iOS 6 or later. Requires ARC  ,support iPhone/iPad.
* iOS 6及以上系统可使用. 本控件纯ARC，支持iPhone/iPad横竖屏

## More 更多 

Please create a issue if you have any questions.
Welcome to visit my [Blog](http://blog.viiio.com/ "Vision的博客")

## Licenses
All source code is licensed under the [MIT License](https://github.com/VIIIO/VisionSlideSegmentView/blob/master/LICENSE "License").

