//
//  Person.h
//  TestMagicalRecord
//
//  Created by matsuda on 12/05/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Person : NSManagedObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *age;

@end
