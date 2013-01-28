//
//  RootViewController.m
//  TestContainerController
//
//  Created by Kosuke Matsuda on 2013/01/28.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "RootViewController.h"
#import "SlideSegue.h"

#if DEBUG
@interface UIView (Debug)
- (NSString *)recursiveDescription;
@end
#endif

@interface RootViewController () {
    UIView *_backView;
    NSInteger _childIndex;
}

@end

@implementation RootViewController

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
    _backView = [[UIView alloc] initWithFrame:CGRectMake(60, 60, 200, 300)];
    _backView.backgroundColor = [UIColor orangeColor];
    _backView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_backView];

    NSArray *controllers = @[
        [self.storyboard instantiateViewControllerWithIdentifier:@"0"],
        [self.storyboard instantiateViewControllerWithIdentifier:@"1"],
        [self.storyboard instantiateViewControllerWithIdentifier:@"2"]
    ];
    for (UIViewController *c in controllers) {
        c.view.frame = _backView.bounds;
        [self addChildViewController:c];
    }

    _childIndex = 0;
    UIViewController *controller = (UIViewController *)controllers[_childIndex];
    [_backView addSubview:controller.view];

    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwitch:)];
    rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    rightGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:rightGesture];

    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwitch:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    leftGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:leftGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segueDidComplete:(SlideSegue *)segue
{
    // NSLog(@"%@", [self.view recursiveDescription]);
}

- (void)slideSegueToViewIndex:(NSInteger)toIndex toLeft:(BOOL)toLeft
{
    UIViewController *source = self.childViewControllers[_childIndex];
    UIViewController *destination = self.childViewControllers[toIndex];
    SlideSegue *segue = [[SlideSegue alloc] initWithIdentifier:@"SlideSegue" source:source destination:destination];
    segue.toLeft = toLeft;
    segue.delegate = self;
    [segue perform];
    _childIndex = toIndex;
}

- (void)rightSwitch:(UISwipeGestureRecognizer *)gesture
{
    NSInteger toIndex = _childIndex - 1;
    if (toIndex < 0) {
        toIndex = [self.childViewControllers count] - 1;
    }
    [self slideSegueToViewIndex:toIndex toLeft:NO];
}

- (void)leftSwitch:(UISwipeGestureRecognizer *)gesture
{
    NSInteger toIndex = _childIndex + 1;
    if (toIndex >= [self.childViewControllers count]) {
        toIndex = 0;
    }
    [self slideSegueToViewIndex:toIndex toLeft:YES];
}

/*
- (void)rightSwitch:(UISwipeGestureRecognizer *)gesture
{
    NSInteger newIndex = _childIndex - 1;
    if (newIndex < 0) {
        newIndex = [self.childViewControllers count] - 1;
    }
    __weak UIViewController *source = self.childViewControllers[_childIndex];
    __weak UIViewController *destination = self.childViewControllers[newIndex];
    __weak RootViewController *wself = self;
    _backView.clipsToBounds = YES;
    CGRect startRect = source.view.bounds;
    CGRect endRect = startRect;
    endRect.origin.x = source.view.bounds.origin.x + source.view.bounds.size.width;
    CGRect preRect = startRect;
    preRect.origin.x = source.view.bounds.origin.x - source.view.bounds.size.width;
    destination.view.frame = preRect;

    [self transitionFromViewController:source
                      toViewController:destination
                              duration:0.5f
                               options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationCurveEaseInOut)
                            animations:^{
                                source.view.frame = endRect;
                                destination.view.frame = startRect;
                            }
                            completion:^(BOOL finished){
                                // [source.view removeFromSuperview];
                                // [_backView addSubview:destination.view];
                                _childIndex--;
                                if (_childIndex < 0) {
                                    _childIndex = [wself.childViewControllers count] - 1;
                                }
                            }];
}

- (void)leftSwitch:(UISwipeGestureRecognizer *)gesture
{
    NSInteger newIndex = _childIndex + 1;
    if (newIndex >= [self.childViewControllers count]) {
        newIndex = 0;
    }
    __weak UIViewController *source = self.childViewControllers[_childIndex];
    __weak UIViewController *destination = self.childViewControllers[newIndex];
    // __weak RootViewController *wself = self;
    _backView.clipsToBounds = YES;
    CGRect startRect = source.view.bounds;
    CGRect endRect = startRect;
    endRect.origin.x = source.view.bounds.origin.x - source.view.bounds.size.width;
    CGRect preRect = startRect;
    preRect.origin.x = source.view.bounds.origin.x + source.view.bounds.size.width;
    destination.view.frame = preRect;

    [self transitionFromViewController:source
                      toViewController:destination
                              duration:0.5f
                               options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationCurveEaseInOut)
                            animations:^{
                                source.view.frame = endRect;
                                destination.view.frame = startRect;
                            }
                            completion:^(BOOL finished){
                                // [source.view removeFromSuperview];
                                // [_backView addSubview:destination.view];
                                _childIndex++;
                                if (_childIndex >= [self.childViewControllers count]) {
                                    _childIndex = 0;
                                }
                            }];
}
 */

@end
