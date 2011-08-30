//
//  TestLocalNotificationAppDelegate.h
//  TestLocalNotification
//
//  Created by Kosuke Matsuda on 11/08/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestLocalNotificationViewController;

@interface TestLocalNotificationAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TestLocalNotificationViewController *viewController;

@end
