//
//  TestFacebookAppDelegate.h
//  TestFacebook
//
//  Created by Kosuke Matsuda on 11/08/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestFacebookViewController;

@interface TestFacebookAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TestFacebookViewController *viewController;

@end
