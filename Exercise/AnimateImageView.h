//
//  AnimateImageView.h
//  Exercise
//
//  Created by JerryLin on 14-4-27.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyImageViewDelegate <NSObject>

- (void)appear;
- (void)disappear;

- (void)animateAppearWithOption:(NSInteger)opt interval:(NSTimeInterval)interval;

@end

@interface AnimateImageView : UIImageView <MyImageViewDelegate>





@end
