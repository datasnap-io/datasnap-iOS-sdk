//
//  DSIOUser.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "DSIOAudience.h"
#import "DSIOEventProperty.h"
#import "DSIOIdentifier.h"
#import "DSIOTags.h"
#import "DSIOUserProperties.h"

@interface DSIOUser : DSIOEventProperty
@property DSIOTags* tags;
@property DSIOIdentifier* identifier;
@property DSIOAudience* DSIOAudience;
@property DSIOUserProperties* userProperties;
@property (nonatomic, strong) DSIOUser* user;
- (void)initializeUser:(DSIOUser*)user;
- (DSIOUser*)getInstance;
- (NSDictionary*)convertToDictionary;
@end
