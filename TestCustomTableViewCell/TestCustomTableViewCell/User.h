//
//  User.h
//  TestCustomTableViewCell
//
//  Created by matsuda on 12/05/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *memo;

- (id)initWithName:(NSString *)name memo:(NSString *)memo;

+ (NSArray *)usersWithMock;

@end
