//
//  AnimateImageView.m
//  Exercise
//
//  Created by JerryLin on 14-4-27.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "AnimateImageView.h"

@implementation AnimateImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)appear
{
    [self sizeToFit];
    self.alpha = 1;
}

- (void)disappear
{
    self.alpha = 0;
}

- (void)animateAppearWithOption:(NSInteger)opt interval:(NSTimeInterval)interval
{
    
    CGPoint initCenter = self.center;
    
    //CGRect frame = self.frame;
    __weak AnimateImageView * wself = self;
    if (opt == 0) {
        self.center = CGPointMake(initCenter.x, initCenter.y + 10 );
        self.alpha = 0;
        [UIView animateWithDuration:interval
                         animations:^{
                             wself.alpha = 1;
                             wself.transform = CGAffineTransformRotate(CGAffineTransformIdentity, arc4random()%30 - 15);
                             wself.center = initCenter;
                         }];
    }
    
    if (opt ==1) {
        
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
        self.alpha = 1;
        [UIView animateWithDuration:interval
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             wself.transform = CGAffineTransformRotate(CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5), 5- arc4random()%10 );
                             wself.center = initCenter;
                         }
                         completion:NULL];
    }
}


@end
