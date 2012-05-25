//
//  User.m
//  TestCustomTableViewCell
//
//  Created by matsuda on 12/05/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize name = _name;
@synthesize memo = _memo;

- (id)initWithName:(NSString *)name memo:(NSString *)memo
{
    self = [super init];
    if (self) {
        self.name = name;
        self.memo = memo;
    }
    return self;
}

+ (NSArray *)usersWithMock
{
    User *u1 = [[User alloc] initWithName:@"foo" memo:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."];
    User *u2 = [[User alloc] initWithName:@"bar" memo:@"Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."];
    User *u3 = [[User alloc] initWithName:@"buzz" memo:@"Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "];
    User *u4 = [[User alloc] initWithName:@"uba" memo:@"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."];
    return [NSArray arrayWithObjects:u1, u2, u3, u4, nil];
}

@end
