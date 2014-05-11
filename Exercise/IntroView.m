//
//  IntroView.m
//  IntroView
//
//  Created by JerryLin on 14-4-25.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "IntroView.h"
#import "IntroPage.h"



@implementation IntroView

@synthesize scrollPages = _scrollPages;
@synthesize bottomLabels = _bottomLabels;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //self.backgroundColor = [UIColor greenColor];
        
        [self applyDefaults];
        [self buildView];
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame IntroPages:(NSMutableArray *)pages
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //self.backgroundColor = [UIColor greenColor];
        
        [self applyDefaults];
        
        [self.bottomLabels removeAllObjects];
        for (IntroPage * page in pages) {
            [self.bottomLabels addObject:page.bottomLabel];
        }
        self.scrollPages = pages;
        [self buildScrollViewWithPages:self.scrollPages];
        [self buildButtomScrollViewWithBottomLabels:self.bottomLabels];
        [self buildView];
        
        
    }
    return self;
}



- (void)applyDefaults
{
    self.bottomScrollViewY = BOTTOM_SCROLLVIEW_Y;
    
    self.pageControllY = PAGECONTROL_Y;
    
    self.buttonViewY = BUTTON_VIEW_Y;
    
    self.scrollView.delegate = self;
    self.bottomScrollView.delegate = self;
    
}


- (void)buildView
{
    //add scrollView
    
    //self.scrollView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.scrollView];
    
    //add bottomScrollView
    
    //self.bottomScrollView.backgroundColor = [UIColor blackColor];
    
    [self addSubview:self.bottomScrollView];
    
    //add pageControll
    self.pageControll.numberOfPages = self.scrollPages.count;
    self.pageControll.currentPage = 0;
    self.pageControll.enabled = NO;
    self.pageControll.backgroundColor = [UIColor clearColor];
    self.pageControll.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControll.alpha = 1;
    //self.pageControll.defersCurrentPageDisplay
    [self addSubview:self.pageControll];
    
    //add buttonView
    self.leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    self.leftButton.backgroundColor = [UIColor orangeColor];
    self.leftButton.layer.masksToBounds = YES;
    self.leftButton.layer.cornerRadius = 10.0;
    [self.leftButton setTitle:@"Login" forState:UIControlStateNormal];
    
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    self.rightButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.layer.masksToBounds = YES;
    self.rightButton.layer.cornerRadius = 10.0;
    [self.rightButton setTitle:@"Register" forState:UIControlStateNormal];
    
    
    self.buttonView.backgroundColor = [UIColor whiteColor];
    self.buttonView.alpha = 0.4;
    
    [self addSubview:self.buttonView];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self setupLayout];
    
    [self showPageIndex:0];
    [self.scrollPages[0] didDisappear];
    [self.scrollPages[0] didAppearWithOption:0 interval:0.2];
    
}

- (void)setupLayout
{
    self.leftButton.frame = CGRectMake(15, self.frame.size.height-BUTTON_VIEW_Y-BUTTON_VIEW_HEIGHT, 130, BUTTON_VIEW_HEIGHT);
    self.rightButton.frame = CGRectMake(self.frame.size.width-145, self.frame.size.height-BUTTON_VIEW_Y-BUTTON_VIEW_HEIGHT, 130, BUTTON_VIEW_HEIGHT);
    self.pageControll.frame = CGRectMake(0,self.frame.size.height-PAGECONTROL_Y-PAGECONTROL_HEIGHT,self.frame.size.width, PAGECONTROL_HEIGHT);
    self.bottomScrollView.frame = CGRectMake(0,self.frame.size.height-BOTTOM_SCROLLVIEW_HEIGHT-BOTTOM_SCROLLVIEW_Y,self.frame.size.width, BOTTOM_SCROLLVIEW_HEIGHT);
    
}

- (void)buildScrollViewWithPages:(NSMutableArray *)pages
{
    CGFloat Xoffset = 0;
    for (IntroPage * page in pages) {
        
        page.frame = CGRectMake(Xoffset, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        Xoffset += self.frame.size.width;
        [self.scrollView addSubview:page];
    }
    self.scrollView.contentSize = CGSizeMake(Xoffset, self.scrollView.frame.size.height);
    
    
}

- (void)buildButtomScrollViewWithBottomLabels:(NSMutableArray *)labels
{
    CGFloat Yoffset = 0;
    for (UILabel *label in labels) {
        label.frame = CGRectMake(0, Yoffset, self.bottomScrollView.frame.size.width, BOTTOM_SCROLLVIEW_HEIGHT);
        Yoffset += BOTTOM_SCROLLVIEW_HEIGHT;
        [self.bottomScrollView addSubview:label];
    }
    self.bottomScrollView.contentSize = CGSizeMake(self.bottomScrollView.frame.size.width, Yoffset);
}

#pragma - mark proporties

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
    }
    return _scrollView;
}

- (UIScrollView *)bottomScrollView
{
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-self.bottomScrollViewY-BOTTOM_SCROLLVIEW_HEIGHT, self.frame.size.width, BOTTOM_SCROLLVIEW_HEIGHT)];
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.delegate = self;
        _bottomScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
    }
    return _bottomScrollView;
}

- (UIPageControl *)pageControll
{
    
    if (!_pageControll) {
        _pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-self.pageControllY, self.frame.size.width, PAGECONTROL_HEIGHT)];
        _pageControll.currentPage = 0;
        _pageControll.enabled = YES;
    }
    
    return _pageControll;
}

- (UIView *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-self.buttonViewY-BUTTON_VIEW_HEIGHT, self.frame.size.width, BUTTON_VIEW_HEIGHT)];
        
    }
    return _buttonView;
}

- (NSMutableArray *)scrollPages
{
    if (!_scrollPages) {
        _scrollPages = [NSMutableArray arrayWithCapacity:10];
    }
    return _scrollPages;
}

- (void)setScrollPages:(NSMutableArray *)scrollPages
{
    _scrollPages = scrollPages;
}

- (NSMutableArray *)bottomLabels;
{
    if (!_bottomLabels) {
        _bottomLabels = [NSMutableArray arrayWithCapacity:10];
    }
    return _bottomLabels;
}

- (void)setBottomLabels:(NSMutableArray *)bottomLabels
{
    
    _bottomLabels = bottomLabels;
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   /* if (scrollView == self.scrollView) {
        CGPoint offset = scrollView.contentOffset;
        CGFloat blue = 200 - offset.x*200/scrollView.contentSize.width;
        //set backgroundcolor
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:blue alpha:1];
    }
    */
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    if (scrollView == self.scrollView) {
        self.lastPageIndex = self.currentPageIndex;
        self.currentPageIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
        self.pageControll.currentPage = self.currentPageIndex;
        
        if (self.lastPageIndex != self.currentPageIndex) {
            
            [self showPageIndex:self.currentPageIndex];
            [self.scrollPages[self.currentPageIndex] didAppearWithOption:self.currentPageIndex interval:0.3];
            [self.scrollPages[self.lastPageIndex] didDisappear];
            
        }
        
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

#pragma mark - helper

- (void)showPageIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index*self.scrollView.frame.size.width, 0) animated:YES];
    [self.bottomScrollView setContentOffset:CGPointMake(0, index*self.bottomScrollView.frame.size.height) animated:YES];
    
    
    UIColor *color = [self colorForIndex:index];
    __weak IntroView * wself = self;
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         wself.backgroundColor = color;
                     }];
    
}

- (UIColor *)colorForIndex:(NSInteger)index
{
    
    switch (index) {
        case 0:
            return [UIColor purpleColor];
            break;
            
        case 1:
            return [UIColor blueColor];
            break;
        default:
            return [UIColor whiteColor];
            break;
    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
