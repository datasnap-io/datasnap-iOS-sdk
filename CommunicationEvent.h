//
//  CommunicationEvent.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//
#import "BaseEvent.h"
#import "DSIOCampaign.h"
#import "DSIOCommunication.h"
#import "DSIODeviceInfo.h"
#import "DSIOPlace.h"
#import "DSIOUser.h"
#import <Foundation/Foundation.h>

@interface CommunicationEvent : BaseEvent
@property DSIOCommunication* communication;
@property DSIOCampaign* campaign;
@end
