//
//  FMDatabase+Migration.h
//  TestFMDB
//
//  Created by matsuda on 12/05/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FMDatabase.h"

typedef BOOL (^FMDBMigrationBlock)(FMDatabase *db, NSInteger version);

@interface FMDatabase (FMDatabaseMigration)

+ (id)databaseWithFileName:(NSString *)fileName;
- (id)initWithFileName:(NSString *)fileName;
- (BOOL)migrateWithBlock:(FMDBMigrationBlock)block;
- (BOOL)migrateWithMigrator:(id<NSObject>)migrator;

@end
