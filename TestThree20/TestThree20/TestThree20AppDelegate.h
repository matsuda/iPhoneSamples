//
//  TestThree20AppDelegate.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/08/31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@class TestThree20ViewController;

@interface TestThree20AppDelegate : NSObject <UIApplicationDelegate> {
    UINavigationController* navigationController_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController* navigationController;

@end
