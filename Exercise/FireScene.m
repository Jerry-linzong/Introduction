//
//  FireScene.m
//  Exercise
//
//  Created by JerryLin on 14-4-29.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "FireScene.h"


@interface FireScene ()

@property (nonatomic, retain) SKLabelNode *headLabel;

@property (nonatomic, retain) SKEmitterNode *emiter;

@property (nonatomic) BOOL contentCreated;

@end


@implementation FireScene

- (instancetype)initWithSize:(CGSize)size
{
    
    
    if (self = [super initWithSize:size]) {
        self.presented = NO;
        
        //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.backgroundColor = [UIColor blackColor];
        self.headLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Regular"];
        self.headLabel.text = @"Burning";
        self.headLabel.fontSize = 30;
        self.headLabel.position = CGPointMake(CGRectGetMidX(self.frame), 400);
        [self addChild:self.headLabel];
        
        
        self.emiter.position = CGPointMake(CGRectGetMidX(self.frame), 100);
        self.emiter.targetNode = self;
        
        [self addChild:self.emiter];
        

    }
    

    
    return self;

}

- (SKEmitterNode *)emiter
{
    if (!_emiter) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"FireEmitter" ofType:@"sks"];
        _emiter = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
    }
    
    return _emiter;
}


- (void)didMoveToView:(SKView *)view
{
    self.presented = YES;
}

-(void)willMoveFromView:(SKView *)view
{
    self.presented = NO;
}


@end
