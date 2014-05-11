//
//  ShouyeTableViewController.h
//  Exercise
//
//  Created by JerryLin on 14-5-3.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Intro.h"
#import "ShouyeTableViewCell.h"

@interface ShouyeTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchController;
@property (nonatomic) NSManagedObjectContext *managedContext;

/*
@property (nonatomic) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;
*/
@end
