//
//  CommunicationEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "Campaign.h"
#import "Communication.h"
#import "Place.h"
#import "User.h"
#import <Foundation/Foundation.h>

@interface CommunicationEvent : BaseEvent
@property Communication* communication;
@property Campaign* campaign;
@property NSString* created;
@property Device* device;
@property NSString* dataSnapVersion;
@property NSString* eventType;
@property NSArray* organization_Ids;
@property NSArray* project_Ids;
@property NSString* customerOrgId;
@property NSString* customerVenueOrgId;
@property NSString* venueOrgId;
@property User* user;
@property NSDictionary* additionalProperties;
- (CommunicationEvent*)initWithEventType:(NSString*)eventType
                           communication:(Communication*)communication
                                campaign:(Campaign*)campaign
                              venueOrgId:(NSString*)venueId
                           customerOrgId:(NSString*)customerOrgId;

- (BOOL)isValid;
@end
