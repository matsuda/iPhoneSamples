//
//  TestThree20AppDelegate.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/08/31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestThree20ViewController;

@interface TestThree20AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TestThree20ViewController *viewController;

@end
