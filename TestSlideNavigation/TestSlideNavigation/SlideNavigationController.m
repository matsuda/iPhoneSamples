//
//  SlideNavigationController.m
//  TestSlideNavigationController
//
//  Created by matsuda on 12/05/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SlideNavigationController.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const kSlideKeepWidth = 40.f;

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

@synthesize topViewController = _topViewController;
@synthesize leftViewController = _leftViewController;
@synthesize rightViewController = _rightViewController;

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

    [self updateLeftViewLayout];
    [self.view insertSubview:_leftViewController.view atIndex:0];
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    [_rightViewController.view removeFromSuperview];
    [_rightViewController removeFromParentViewController];

    _rightViewController = rightViewController;
    [self addChildViewController:rightViewController];

    [self updateRightViewLayout];
    [self.view insertSubview:_rightViewController.view atIndex:0];
}

- (void)updateLeftViewLayout
{
//    self.leftViewController.view.autoresizingMask = (
//                                                     UIViewAutoresizingFlexibleWidth |
//                                                     UIViewAutoresizingFlexibleHeight |
//                                                     UIViewAutoresizingFlexibleTopMargin |
//                                                     UIViewAutoresizingFlexibleBottomMargin |
//                                                     UIViewAutoresizingFlexibleLeftMargin |
//                                                     UIViewAutoresizingFlexibleRightMargin);
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGRect f = self.view.bounds;
    f.size.width = width - kSlideKeepWidth;
    self.leftViewController.view.frame = f;
}

- (void)updateRightViewLayout
{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGRect f = self.view.bounds;
    f.origin.x = kSlideKeepWidth;
    f.size.width = width - kSlideKeepWidth;
    self.rightViewController.view.frame = f;
}

- (void)leftViewWillAppear
{
    self.rightViewController.view.hidden = YES;
    self.leftViewController.view.hidden = NO;
}

- (void)rightViewWillAppear
{
    self.leftViewController.view.hidden = YES;
    self.rightViewController.view.hidden = NO;
}

- (void)slideTo:(SlideNavigationControllerSide)side
{
    CGFloat distance;
    __block CGRect f = self.topViewController.view.frame;

    switch (side) {
        case SlideNavigationControllerSideLeft: {
            if (f.origin.x <= 0.f) {
                distance = f.size.width - kSlideKeepWidth;
            } else {
                distance = 0.f - f.origin.x;
            }
            break;
        }
        default: {
            if (f.origin.x >= 0.f) {
                distance = kSlideKeepWidth - f.size.width;
            } else {
                distance = 0.f - f.origin.x;
            }
            break;
        }
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
    switch (side) {
        case SlideNavigationControllerSideLeft: {
            if (distance >= 0.f) {
                [self leftViewWillAppear];
            }
            break;
        }
        default: {
            if (distance <= 0.f) {
                [self rightViewWillAppear];
            }
            break;
        }
    }
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
