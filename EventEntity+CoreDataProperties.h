//
//  Event+CoreDataProperties.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EventEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString* json;

@end

NS_ASSUME_NONNULL_END
