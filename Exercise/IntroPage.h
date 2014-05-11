//
//  IntroPage.h
//  Exercise
//
//  Created by JerryLin on 14-4-27.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimateImageView.h"
#import "IntroView.h"
#import "CustomView.h"

@interface IntroPage : UIView <SetTiTle>

@property (nonatomic) UILabel *headLabel;

@property (nonatomic) UILabel *bottomLabel;

@property (nonatomic) NSMutableArray *imageViews;



@property (nonatomic, retain) UIView *customView;


- (instancetype)initWithFrame:(CGRect)frame headTitle:(NSString *)title bottomTitle:(NSString *)btitle images:(NSMutableArray *)images;

- (instancetype)initWithCustomView:(UIView *)view bTitle:(NSString *)title;

- (void)setBottomTitle:(NSString *)title;

- (void)didAppearWithOption:(NSInteger)opt interval:(NSTimeInterval)interval;
- (void)didDisappear;

@end
