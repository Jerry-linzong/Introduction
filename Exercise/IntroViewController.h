//
//  ViewController.h
//  Exercise
//
//  Created by JerryLin on 14-4-27.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "CustomView.h"
#import "FirstViewController.h"

@interface IntroViewController : UIViewController

@property (nonatomic) NSManagedObjectContext *managedContext;

@end
