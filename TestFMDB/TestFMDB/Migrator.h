//
//  Migrator.h
//  TestFMDB
//
//  Created by matsuda on 12/05/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface Migrator : NSObject

- (void)upVer1:(FMDatabase *)db;
- (void)upVer2:(FMDatabase *)db;

@end
