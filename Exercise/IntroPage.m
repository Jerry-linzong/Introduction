//
//  IntroPage.m
//  Exercise
//
//  Created by JerryLin on 14-4-27.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "IntroPage.h"

@implementation IntroPage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame headTitle:(NSString *)title bottomTitle:(NSString *)btitle images:(NSMutableArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.headLabel.text = title;
        self.bottomLabel.text = btitle;
        [self setupImages:images];
        [self buildView];
        
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)view bTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        // Initialization code
        self.customView = view;
        self.bottomLabel.text = title;
        
        self.bottomLabel.frame = CGRectMake(0, self.frame.size.height-BOTTOM_SCROLLVIEW_Y-BOTTOM_SCROLLVIEW_HEIGHT, self.frame.size.width, BOTTOM_SCROLLVIEW_HEIGHT);
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.textColor = [UIColor whiteColor];
        self.bottomLabel.font = [UIFont fontWithName:@"ChalkboardSE-Regular" size:12];
        
        [self addSubview:self.customView];
    }
    return self;
}


- (void)buildView
{
    
    
    //add imageViews
    for (AnimateImageView *v  in self.imageViews) {
        [self addSubview:v];
    }
    
    //add headLabel
    [self addSubview:self.headLabel];
    [self setupLayout];
}

- (void)setupLayout
{
    
    self.headLabel.frame = CGRectMake(0, headLabelY, self.frame.size.width, headLabelH);
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    
    self.bottomLabel.frame = CGRectMake(0, self.frame.size.height-BOTTOM_SCROLLVIEW_Y-BOTTOM_SCROLLVIEW_HEIGHT, self.frame.size.width, BOTTOM_SCROLLVIEW_HEIGHT);
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.textColor = [UIColor whiteColor];
    self.bottomLabel.font = [UIFont fontWithName:@"ChalkboardSE-Regular" size:12];
    int count = self.imageViews.count/2;
    //int space = 1 + count;
    
    
    CGFloat margin = 5;
    CGFloat imageViewwidth = (self.frame.size.width- 2*margin)/count;
    for (int i = 0; i<self.imageViews.count; i++) {
        int line = i / count;
        int colum = i % count;
        CGFloat x = margin + colum * imageViewwidth;
        CGFloat y = 0;
        if (line == 0) {
            y = imageLineCenterY0;
        }
        if (line ==1) {
            y = imageLineCenterY1;
        }
        AnimateImageView *imageView = self.imageViews[i];
        
        [imageView sizeToFit];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        CGRect rect = [imageView frame];
        
        CGFloat imageViewHeight = imageViewwidth * rect.size.height / rect.size.width;
        
        //[self.imageViews[i] setFrame:CGRectMake(x-rect.size.width/2, y-rect.size.height/2, rect.size.width, rect.size.height)];
        imageView.frame = CGRectMake(x, y-imageViewHeight/2, imageViewwidth, imageViewHeight);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 4;
        imageView.layer.borderColor = (__bridge CGColorRef)([UIColor purpleColor]);
        imageView.layer.borderWidth = 1;
        
        imageView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, (5 - (arc4random()%10)));
        
        
        
    }
}



- (void)setupImages:(NSMutableArray *)images
{
    [self.imageViews removeAllObjects];
    
    for (UIImage * image in images) {
        AnimateImageView * imageV = [[AnimateImageView alloc] initWithImage:image];
        [imageV sizeToFit];
        [self.imageViews addObject:imageV];
    }
    
    
}

- (void)didAppearWithOption:(NSInteger)opt interval:(NSTimeInterval)interval
{
    
    
    for (int i = 0; i<self.imageViews.count; i++) {
        AnimateImageView *imageView = self.imageViews[i];
        [UIView animateWithDuration:interval
                              delay:i*interval
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [imageView animateAppearWithOption:opt interval:interval];
                         }
                         completion:NULL];
    }
    
    
}

- (void)didDisappear
{
    for (AnimateImageView * view in self.imageViews) {
        view.alpha = 0;
    }
}

#pragma mark - properties

- (UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, headLabelH)];
    }
    return _headLabel;
}


- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _bottomLabel;
}

- (NSMutableArray *)imageViews
{
    if (!_imageViews) {
        _imageViews = [NSMutableArray arrayWithCapacity:10];
    }
    return _imageViews;
}

- (void)setBottomTitle:(NSString *)title
{
    self.bottomLabel.text = title;
}

- (void)setTitle:(NSString *)title
{
    [self setBottomTitle:title];
    
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
