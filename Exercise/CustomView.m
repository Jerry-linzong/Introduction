//
//  CustomView.m
//  Exercise
//
//  Created by JerryLin on 14-4-29.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "CustomView.h"
#import "SnowScene.h"
#import "FireScene.h"

@interface CustomView ()

@property (nonatomic, retain) SnowScene *snowScene;
@property (nonatomic, retain) FireScene *fireScene;


@end


@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.delegate = nil;
        
        [self presentScene:self.snowScene];
        
        UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        g.numberOfTapsRequired = 2;
        g.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:g];
        
    }
    return self;
}

- (void)tapHandle:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized) {
        
        if (!self.fireScene.presented) {
            SKTransition *t = [SKTransition doorsCloseHorizontalWithDuration:0.6];
            [self presentScene:self.fireScene transition:t];
            if ([self.delegate performSelector:@selector(setTitle:)] ) {
                [self.delegate setTitle:@"Love Burning"];
            }
        }
        
        if (!self.snowScene.presented) {
            SKTransition *t = [SKTransition flipHorizontalWithDuration:0.6];
            [self presentScene:self.snowScene transition:t];
            if ([self.delegate performSelector:@selector(setTitle:)] ) {
                [self.delegate setTitle:@"Love Snowing"];
            }
        }
        
    }
}

- (SnowScene *)snowScene
{
    if (!_snowScene) {
        _snowScene = [SnowScene sceneWithSize:self.frame.size];
    }
    return _snowScene;
}

- (FireScene *)fireScene
{
    if (!_fireScene) {
        _fireScene = [FireScene sceneWithSize:self.frame.size];
    }
    return _fireScene;
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
