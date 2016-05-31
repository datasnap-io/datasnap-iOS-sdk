//
//  CoreDataHelper.h
//  datasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 5/31/16.
//  Copyright © 2016 DataSnap. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject
@property (nonatomic, strong, readonly) NSManagedObjectContext* context;
@property (nonatomic, strong, readonly) NSManagedObjectModel* model;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator* coordinator;
@property (nonatomic, strong, readonly) NSPersistentStore* store;
+ (id)sharedManager;
- (void)saveInMainContext;
- (void)saveInContext:(NSManagedObjectContext*)localContext;
@end
