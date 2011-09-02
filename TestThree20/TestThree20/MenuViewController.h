//
//  MenuViewController.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : TTViewController <TTLauncherViewDelegate, TTSearchTextFieldDelegate> {
    TTLauncherView* launcherView_;
    UIViewController* viewController_;

    NSString* urlToOpen_;
}

@property (nonatomic, retain) UIViewController* viewController;

@end
