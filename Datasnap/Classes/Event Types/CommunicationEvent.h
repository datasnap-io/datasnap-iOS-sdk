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
- (CommunicationEvent*)initWithEventType:(NSString*)eventType
                           communication:(Communication*)communication
                                campaign:(Campaign*)campaign
                              venueOrgId:(NSString*)venueId
                           customerOrgId:(NSString*)customerOrgId;

- (BOOL)isValid;
@end
