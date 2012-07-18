//
//  Person.m
//  TestGHUnit
//
//  Created by matsuda on 12/07/18.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize firstName = _firstName, lastName = _lastName;

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}

@end
