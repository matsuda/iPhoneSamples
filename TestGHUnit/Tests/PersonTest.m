//
//  PersonTest.m
//  TestGHUnit
//
//  Created by matsuda on 12/07/18.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "Person.h"

@interface PersonTest : GHTestCase {
    Person *_person;
}
@end

@implementation PersonTest

- (void)setUpClass
{
    NSLog(@"aaaaaaaaaaaaaaaa");
}

- (void)setUp
{
    NSLog(@"bbbbbbbbbbbbbbbbb");
    _person = [[Person alloc] init];
}

- (void)testFirstName
{
    NSLog(@"cccccccccccccccccc");
    NSString *firstName = @"Koh";
    _person.firstName = firstName;
    GHAssertEqualObjects(_person.firstName, firstName, @"should be equal.");
}

- (void)testFullName
{
    NSLog(@"dddddddddddddd");
    NSString *firstName = @"Koh";
    NSString *lastName = @"Mat";
    _person.firstName = firstName;
    _person.lastName = lastName;
    GHAssertEqualObjects(_person.fullName, @"Koh Mat", @"Fullname is %@ + %@.", firstName, lastName);
//    GHAssertEqualObjects(_person.fullName, firstName, @"Fullname is %@ + %@.", firstName, lastName);
}

@end
