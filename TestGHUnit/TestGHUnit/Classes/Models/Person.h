//
//  Person.h
//  TestGHUnit
//
//  Created by matsuda on 12/07/18.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

- (NSString *)fullName;

@end
