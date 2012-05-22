//
//  SlideNavigationController.h
//  TestSlideNavigationController
//
//  Created by matsuda on 12/05/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SlideNavigationControllerSideLeft,
    SlideNavigationControllerSideRight,
} SlideNavigationControllerSide;

@interface SlideNavigationController : UIViewController

@property (nonatomic, strong) UIViewController *topViewController;
@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *rightViewController;

- (void)slideTo:(SlideNavigationControllerSide)side;
- (void)slideOffScreenTo:(SlideNavigationControllerSide)side complete:(void(^)())complete;
- (void)slideResetTo:(SlideNavigationControllerSide)side;
- (void)resetTopView:(SlideNavigationControllerSide)side;

@end

@interface UIViewController (SlideNavigationController)
- (SlideNavigationController *)slideNavigationController;
@end