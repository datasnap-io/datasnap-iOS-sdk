//
//  Audience.m
//  dataSnapSample
//
//  Created by Alyssa McIntyre on 6/8/16.
//  Copyright © 2016 Datasnapio. All rights reserved.
//

#import "Audience.h"

@implementation Audience
- (NSDictionary*)convertToDictionary
{
    NSDictionary* dictionary = @{
        @"education" : self.education ? self.education : [NSNull null],
        @"college" : self.college ? self.college : [NSNull null],
        @"age" : self.age ? self.age : [NSNull null],
        @"ethnicity" : self.ethnicity ? self.ethnicity : [NSNull null],
        @"kids" : self.kids ? self.kids : [NSNull null],
        @"gender" : self.gender ? self.gender : [NSNull null],
        @"interests" : self.interests ? self.interests : [NSNull null],
        @"income" : self.income ? self.income : [NSNull null]
    };
    return dictionary;
}
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
