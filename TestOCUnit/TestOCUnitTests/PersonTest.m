//
//  PersonTest.m
//  TestOCUnit
//
//  Created by matsuda on 12/07/18.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "PersonTest.h"

#import "Person.h"

@interface PersonTest () {
    Person *_person;
}

@end

@implementation PersonTest

- (void)setUp
{
    [super setUp];
    _person = [[Person alloc] init];
}

- (void)testName
{
    NSString *name = @"test";
    _person.name = name;
    STAssertEquals(name, _person.name, @"should be equal.");
}

@end
