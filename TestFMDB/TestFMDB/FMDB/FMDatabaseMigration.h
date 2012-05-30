//
//  FMDatabase+Migration.h
//  TestFMDB
//
//  Created by matsuda on 12/05/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FMDatabase.h"

/*
 ////////////////////////////////////////////////////////////////

 -- AppDelegate.m

 * use databaseWithFileName method instead of databaseWithPath
 * call migrateWithMigrator:migrator

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        FMDatabase *database = [FMDatabase databaseWithFileName:@"test.sql"];
        [database migrateWithMigrator:[[Migrator alloc] init]];
        return YES;
    }

 -- Migrator.h

 * describe "migrateVersion<version number>" method with an argument of FMDatabase object

    #import "FMDatabaseMigration.h"
    @interface Migrator : NSObject
    - (void)migrateVersion1:(FMDatabase *)db;
    @end

 ////////////////////////////////////////////////////////////////
 */

typedef BOOL (^FMDBMigrationBlock)(FMDatabase *db, NSInteger version);

@interface FMDatabase (FMDatabaseMigration)

+ (id)databaseWithFileName:(NSString *)fileName;
- (id)initWithFileName:(NSString *)fileName;
- (BOOL)migrateWithBlock:(FMDBMigrationBlock)block;
- (BOOL)migrateWithMigrator:(id<NSObject>)migrator;

@end
