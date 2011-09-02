//
//  MenuViewController.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface MenuViewController : TTViewController <TTLauncherViewDelegate, TTSearchTextFieldDelegate> {
    TTLauncherView* launcherView_;
}

@end
