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

// Why are we importing this in the header file?
#import <Foundation/Foundation.h>

@interface CommunicationEvent : BaseEvent
@property Communication* communication;
@property Campaign* campaign;
- (CommunicationEvent*)communicationOpenWithCommunication:(Communication*)communication
                                                 campaign:(Campaign*)campaign;
- (CommunicationEvent*)communicationentWithCommunication:(Communication*)communication
                                                campaign:(Campaign*)campaign;
@end
