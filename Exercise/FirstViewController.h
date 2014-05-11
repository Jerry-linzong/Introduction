//
//  FirstViewController.h
//  Exercise
//
//  Created by JerryLin on 14-5-2.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroViewController.h"

@protocol AddViewController <NSObject>

@optional
- (void)addViewControllerDidLaunching:(UIViewController *)newVC;
- (void)addViewCOntrollerwillQuit:(UIViewController *)newVC;

@end

@interface FirstViewController : UIViewController <AddViewController,UIScrollViewDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic) NSManagedObjectContext *managedContext;


- (void)presentViewController:(UIViewController *)viewVC;
@end
