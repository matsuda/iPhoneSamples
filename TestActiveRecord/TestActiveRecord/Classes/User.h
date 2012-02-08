//
//  User.h
//  TestActiveRecord
//
//  Created by matsuda on 12/02/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ActiveRecord/ActiveRecord.h>

/*
 CREATE TABLE users ("id" INTEGER PRIMARY KEY NOT NULL, "firstName" varchar(255) DEFAULT NULL, "lastName" varchar(255) DEFAULT NULL);
 INSERT INTO users VALUES(1, 'ichiro', 'suzuki');
 INSERT INTO users VALUES(2, 'hideo', 'tanaka');
 */
@interface User : ARBase

//@property (nonatomic, copy) NSString *firstName;
//@property (nonatomic, copy) NSString *lastName;
@property(readwrite, assign) NSString *firstName, *lastName;

@end
