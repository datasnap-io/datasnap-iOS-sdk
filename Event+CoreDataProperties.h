//
//  Event+CoreDataProperties.h
//  datasnap-ios-sdk
//
//  Created by Alyssa McIntyre on 5/31/16.
//  Copyright © 2016 DataSnap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *json;

@end

NS_ASSUME_NONNULL_END
