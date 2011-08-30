//
//  KMOpenCVAppDelegate.h
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KMOpenCVViewController;

@interface KMOpenCVAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	UIImage *originalImage_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) UIImage *originalImage;

@end
