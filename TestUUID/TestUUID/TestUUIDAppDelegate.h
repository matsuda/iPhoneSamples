//
//  TestUUIDAppDelegate.h
//  TestUUID
//
//  Created by Kosuke Matsuda on 11/08/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestUUIDViewController;

@interface TestUUIDAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TestUUIDViewController *viewController;

@end
