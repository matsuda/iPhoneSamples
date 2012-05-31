//
//  FMDatabase+Migration.m
//  TestFMDB
//
//  Created by matsuda on 12/05/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FMDatabaseMigration.h"
#import "FMDatabaseAdditions.h"

static NSString * const __FMDB_PROPERY_TABLE_NAME = @"FMDB_PROPERTY";
static NSString * const __VERSION_COLUMN_NAME = @"DBVersion";

@implementation FMDatabase (FMDatabaseMigration)

+ (id)databaseWithFileName:(NSString *)fileName
{
    return FMDBReturnAutoreleased([[self alloc] initWithFileName:fileName]);
}

- (id)initWithFileName:(NSString *)fileName
{
    self = [self initWithPath:nil];
    if (self) {
        _databasePath = [[self databaseFilePathWithFileName:fileName] copy];
        [self initializePropertyTable];
    }
    return self;
}

- (NSString *)databaseFileDir
{
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];

    NSString *applicationName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(NSString *)kCFBundleNameKey];
    NSString *path = [dir stringByAppendingPathComponent:applicationName];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        if ( ![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error] ) {
            NSLog(@"error > %@", error);
        }
    }
    return path;
}

- (NSString *)databaseFilePathWithFileName:(NSString *)fileName
{
    return [[self databaseFileDir] stringByAppendingPathComponent:fileName];
}

- (void)initializePropertyTable
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:_databasePath]) {
        [self open];
        if ( ![self tableExists:__FMDB_PROPERY_TABLE_NAME] ) {
            [self executeQuery:@"PRAGMA foreign_keys = ON"];
            NSString *query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (primaryKey INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value INTEGER)", __FMDB_PROPERY_TABLE_NAME];
            [self executeUpdate:query];
            query = [NSString stringWithFormat:@"INSERT INTO %@ (name, value) VALUES('%@', ?)", __FMDB_PROPERY_TABLE_NAME, __VERSION_COLUMN_NAME];
            [self executeUpdate:query, [NSNumber numberWithInt:0]];
        }
        [self close];
    }
}

- (BOOL)migrateWithBlock:(FMDBMigrationBlock)block
{
    [self open];

    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE name = ?", __FMDB_PROPERY_TABLE_NAME];
    FMResultSet *rs = [self executeQuery:query, __VERSION_COLUMN_NAME];

    NSInteger ver = 0;
    if ([rs next]) {
        ver = [rs intForColumn:@"value"];
    } else {
        abort();
        NSAssert1(false, @"The FMDatabase %@ doesn't have property table.", self);
    }

    NSLog(@"version before migrate >>> %d", ver);

    if (block) {
        BOOL didMigrate = NO;
        ver++;
        didMigrate = block(self, ver);
        while (didMigrate) {
            didMigrate = block(self, ++ver);
        }
        if (!didMigrate) ver--;
    }

    NSLog(@"version after migrate >>> %d", ver);

    query = [NSString stringWithFormat:@"UPDATE %@ SET value = ? WHERE name = ?", __FMDB_PROPERY_TABLE_NAME];
    [self executeUpdate:query, [NSNumber numberWithInt:ver], __VERSION_COLUMN_NAME];

    [self close];

    return YES;
}

- (BOOL)migrateWithMigrator:(id<NSObject>)migrator
{
    return [self migrateWithBlock:^(FMDatabase *db, NSInteger version) {
        NSString *methodName = [NSString stringWithFormat:@"upVer%d:", version];
        SEL method = NSSelectorFromString(methodName);

        if ([migrator respondsToSelector:method]) {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [migrator performSelector:method withObject:self];
#pragma clang diagnostic pop

            method = nil;
            return YES;
        } else {
            method = nil;
            return NO;
        }
    }];
}

@end
