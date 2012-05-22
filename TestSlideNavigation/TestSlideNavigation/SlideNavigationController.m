//
//  SlideNavigationController.m
//  TestSlideNavigationController
//
//  Created by matsuda on 12/05/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SlideNavigationController.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIViewController (SlideNavigationController)

- (SlideNavigationController *)slideNavigationController
{
    UIViewController *viewController = self.parentViewController;
    while (!(viewController == nil || [viewController isKindOfClass:[SlideNavigationController class]])) {
        viewController = viewController.parentViewController;
    }
    return (SlideNavigationController *)viewController;
}

@end


@interface SlideNavigationController ()

@end

@implementation SlideNavigationController

@synthesize leftViewController = _leftViewController;
@synthesize topViewController = _topViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setTopViewController:(UIViewController *)topViewController
{
    [_topViewController.view removeFromSuperview];
    [_topViewController removeFromParentViewController];

    _topViewController = topViewController;
    [self addChildViewController:topViewController];

    _topViewController.view.frame = self.view.bounds;

    [self.view addSubview:_topViewController.view];
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    [_leftViewController.view removeFromSuperview];
    [_leftViewController removeFromParentViewController];

    _leftViewController = leftViewController;
    [self addChildViewController:leftViewController];

    [self updateLeftView];
    [self.view insertSubview:_leftViewController.view atIndex:0];
}

- (void)updateLeftView
{
//    self.leftViewController.view.autoresizingMask = (
//                                                     UIViewAutoresizingFlexibleWidth |
//                                                     UIViewAutoresizingFlexibleHeight |
//                                                     UIViewAutoresizingFlexibleTopMargin |
//                                                     UIViewAutoresizingFlexibleBottomMargin |
//                                                     UIViewAutoresizingFlexibleLeftMargin |
//                                                     UIViewAutoresizingFlexibleRightMargin);
    self.leftViewController.view.frame = self.view.bounds;
}

- (void)slideTo:(SlideNavigationControllerSide)side
{
    CGFloat distance;
    __block CGRect f = self.topViewController.view.frame;

    if (f.origin.x == 0.f) {
        distance = f.size.width - 40.f;
    } else {
        distance = 0.f - f.origin.x;
    }

    [self slideTo:side
         distance:distance
       animations:^{
           f.origin.x += distance;
           self.topViewController.view.frame = f;
       } complete:nil];
}

- (void)slideTo:(SlideNavigationControllerSide)side
       distance:(CGFloat)distance
     animations:(void(^)())animations
       complete:(void(^)())complete
{
    [UIView animateWithDuration:0.25f
                     animations:^{
                         if (animations) {
                             animations();
                         }
                     } completion:^(BOOL finished) {
                         if (complete) {
                             complete();
                         }
                     }];
}

- (void)slideResetTo:(SlideNavigationControllerSide)side
{
    [self slideOffScreenTo:side
                  complete:^{
                      [self resetTopView:side];
                  }];
}

- (void)slideOffScreenTo:(SlideNavigationControllerSide)side complete:(void(^)())complete
{
    __block CGRect f = self.topViewController.view.frame;
    CGFloat toPointX = CGRectGetMaxX([UIScreen mainScreen].bounds);
    CGFloat distance = toPointX - f.origin.x;

    [self slideTo:side
         distance:distance
       animations:^{
           f.origin.x += distance;
           self.topViewController.view.frame = f;
       } complete:^{
           if (complete) {
               complete();
           }
       }];
}

- (void)resetTopView:(SlideNavigationControllerSide)side
{
    __block CGRect f = self.topViewController.view.frame;
    CGFloat toPointX = [UIScreen mainScreen].bounds.origin.x;
    CGFloat distance = toPointX - f.origin.x;

    [self slideTo:side
         distance:distance
       animations:^{
           f.origin.x += distance;
           self.topViewController.view.frame = f;
       } complete:nil];
}


@end
