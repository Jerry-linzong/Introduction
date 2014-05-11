//
//  IntroView.h
//  Exercise
//
//  Created by JerryLin on 14-4-27.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BOTTOM_SCROLLVIEW_HEIGHT    15
#define BOTTOM_SCROLLVIEW_Y         90

#define PAGECONTROL_HEIGHT         14
#define PAGECONTROL_Y               70

#define BOTTOM_SCROLLVIEW_Y         90

#define BUTTON_VIEW_Y               30
#define BUTTON_VIEW_HEIGHT          40

#define imageLineCenterY0  170
#define imageLineCenterY1  280
#define headLabelH   30
#define headLabelY   50


@interface IntroView : UIView <UIScrollViewDelegate>


@property (nonatomic, retain) UIView *bgView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIScrollView *bottomScrollView;
@property (nonatomic, retain) UIView *buttonView;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, retain) UIButton *rightButton;


@property (nonatomic, retain) UIPageControl *pageControll;
@property (nonatomic, retain) NSMutableArray *scrollPages;
@property (nonatomic, retain) NSMutableArray *bottomLabels;
@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger lastPageIndex;



@property (nonatomic) CGFloat bottomScrollViewY;
@property (nonatomic) CGFloat buttonViewY;
@property (nonatomic) CGFloat pageControllY;



- (instancetype)initWithFrame:(CGRect)frame IntroPages:(NSMutableArray *)pages;

- (void)buildScrollViewWithPages:(NSMutableArray *)pages;
- (void)buildButtomScrollViewWithBottomLabels:(NSMutableArray *)labels;





@end
