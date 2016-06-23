//
//  DSIOGEvent+CoreDataProperties.h
//  DSIODatasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 6/22/16.
//  Copyright © 2016 DSIODatasnap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DSIOEventEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSIOEventEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *json;

@end

NS_ASSUME_NONNULL_END
