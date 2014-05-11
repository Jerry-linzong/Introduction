//
//  SnowScene.m
//  Exercise
//
//  Created by JerryLin on 14-4-29.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import "SnowScene.h"


@interface SnowScene ()

@property (nonatomic, retain) SKLabelNode *headLabel;

@property (nonatomic, retain) SKEmitterNode *emiter;

@end



@implementation SnowScene


- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        self.presented = NO;
        
        //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
        //add backgroundimage
        SKSpriteNode *backimage = [SKSpriteNode spriteNodeWithImageNamed:@"xuejing.jpg"];
        
        backimage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:backimage];
        
        self.headLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Regular"];
        self.headLabel.text = @"Snowing ..";
        self.headLabel.fontSize = 30;
        self.headLabel.position = CGPointMake(CGRectGetMidX(self.frame), -50);
        
        
        [self addChild:self.headLabel];
        
        SKTexture *t1 = [SKTexture textureWithImageNamed:@"xiaogou.jpg"];
        SKTexture *t2 = [SKTexture textureWithImageNamed:@"houzi.jpg"];
        SKTexture *t3 = [SKTexture textureWithImageNamed:@"tuzi.jpg"];
        SKTexture *t4 = [SKTexture textureWithImageNamed:@"yazi.jpg"];
        
        
        SKAction *fadein = [SKAction fadeInWithDuration:0.1];
        SKAction *scaleup = [SKAction scaleTo:1 duration:0.1];
        SKAction *wait = [SKAction waitForDuration:1.5];
        SKAction *fadeout = [SKAction fadeOutWithDuration:0.6];
        SKAction *scaledown = [SKAction scaleTo:0.1 duration:0.1];
        SKAction *change1 = [SKAction setTexture:t1 resize:YES];
        SKAction *change2 = [SKAction setTexture:t2 resize:YES];
        SKAction *change3 = [SKAction setTexture:t3 resize:YES];
        SKAction *change4 = [SKAction setTexture:t4 resize:YES];
        
        SKAction *scalein = [SKAction group:@[fadein, scaleup] ];
        SKAction *show = [SKAction sequence:@[scalein, wait, fadeout]];
        SKAction *all = [SKAction sequence:@[show, change1, scaledown,
                                             show, change2, scaledown,
                                             show, change3, scaledown,
                                             show, change4, scaledown,]];
        SKAction *repeat = [SKAction repeatActionForever:all];
        
        SKSpriteNode *imageNode = [SKSpriteNode spriteNodeWithTexture:t4 size:CGSizeMake(0, 0)];
        [imageNode runAction:repeat];
        imageNode.position = CGPointMake(CGRectGetMidX(self.frame), 260);
        [self addChild:imageNode];
        
        self.emiter.position = CGPointMake(CGRectGetMidX(self.frame), 500);
        self.emiter.targetNode = self;
        
        [self addChild:self.emiter];
        
        SKAction *moveup = [SKAction moveToY:400 duration:6];
        [self.headLabel runAction:moveup];
        
        
        
    }
    return self;
}

- (SKEmitterNode *)emiter
{
    if (!_emiter) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"SnowEmitter" ofType:@"sks"];
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
