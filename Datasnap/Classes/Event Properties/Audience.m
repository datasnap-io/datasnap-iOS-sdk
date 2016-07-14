//
//  Audience.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Audience.h"

@implementation Audience

- (Audience*)initWithEducation:(NSString*)education
                       college:(NSString*)college
                           age:(NSString*)age
                     ethnicity:(NSString*)ethnicity
                          kids:(NSString*)kids
                        gender:(NSString*)gender
                     interests:(NSString*)interests
                     andIncome:(NSString*)income
{
    self.education = education;
    self.college = college;
    self.age = age;
    self.ethnicity = ethnicity;
    self.kids = kids;
    self.gender = gender;
    self.interests = interests;
    self.income = income;
    return self;
}
@end
