//
//  Intro.h
//  Exercise
//
//  Created by JerryLin on 14-5-8.
//  Copyright (c) 2014年 immortal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Intro : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSString * desc;

@end
