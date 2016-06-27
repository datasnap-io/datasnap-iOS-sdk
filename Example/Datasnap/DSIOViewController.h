//
//  DSIOViewController.h
//  Datasnap
//
//  Created by Layne McIntyre on 06/24/2016.
//  Copyright (c) 2016 Layne McIntyre. All rights reserved.
//
#import <Datasnap/DataSnap.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton* beaconSightingButton;
@property (weak, nonatomic) IBOutlet UIButton* beaconArrivalButton;
@property (weak, nonatomic) IBOutlet UIButton* beaconDepartButton;
@property (weak, nonatomic) IBOutlet UIButton* geofenceDepartButton;
@property (weak, nonatomic) Datasnap* datasnap;
@end
