//
//  CommunicationEvent.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "CommunicationEvent.h"

@implementation CommunicationEvent
- (CommunicationEvent*)communicationOpenWithCommunication:(Communication*)communication
                                                 campaign:(Campaign*)campaign
{
    self.communication = communication;
    self.campaign = campaign;
    self.event_type = @"ds_communication_open";
    return self;
}
- (CommunicationEvent*)communicationSentWithCommunication:(Communication*)communication
                                                 campaign:(Campaign*)campaign
{
    self.communication = communication;
    self.campaign = campaign;
    self.event_type = @"ds_communication_sent";
    return self;
}
@end
