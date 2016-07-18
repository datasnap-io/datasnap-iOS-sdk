//
//  GlobalPosition.h
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

/*
	Should this even be a class? The coordinates will change on
	every global position event. What benifit is there to making
	a class? Instead, when we call the global position method
	we should pass it coordinated.
*/

@interface GlobalPosition
@property NSArray* coordinates;
- (GlobalPosition*)initWithCoordinates:(NSArray*)coordinates;
@end
