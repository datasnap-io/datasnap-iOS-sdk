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

@interface CommunicationEvent : BaseEvent
@property Communication* communication;
@property Campaign* campaign;
- (CommunicationEvent*)communicationOpenWithCommunication:(Communication*)communication
                                                 campaign:(Campaign*)campaign;
- (CommunicationEvent*)communicationSentWithCommunication:(Communication*)communication
                                                 campaign:(Campaign*)campaign;
@end
