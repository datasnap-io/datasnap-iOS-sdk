//
//  EventEntity+CoreDataProperties.h
//  Pods
//
//  Created by Alyssa McIntyre on 6/24/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EventEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *json;

@end

NS_ASSUME_NONNULL_END
