//
//  AppDelegate.h
//  Exercise
//
//  Created by JerryLin on 14-4-27.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic) NSManagedObjectContext *managedContext;
@property (nonatomic) NSPersistentStoreCoordinator *coordinator;

@property (strong, nonatomic) UIWindow *window;

@end
