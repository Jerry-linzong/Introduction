//
//  CustomView.h
//  Exercise
//
//  Created by JerryLin on 14-4-29.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@protocol SetTiTle <NSObject>

- (void)setTitle:(NSString *)title;

@end

@interface CustomView : SKView

@property (nonatomic, assign) id<SetTiTle>  delegate;

@end
