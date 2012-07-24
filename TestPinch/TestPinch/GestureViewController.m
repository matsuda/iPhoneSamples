//
//  GestureViewController.m
//  TestPinch
//
//  Created by matsuda on 12/07/24.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end

@implementation GestureViewController

@synthesize imageView = _imageView;

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
    NSLog(@"ddddddddddddddddd");
    _imageView.userInteractionEnabled = YES;

	// Do any additional setup after loading the view.
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    rotateGesture.delegate = self;
    [_imageView addGestureRecognizer:rotateGesture];

    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [_imageView addGestureRecognizer:pinchGesture];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [_imageView addGestureRecognizer:panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer
{
    NSLog(@"rotation >>>>>> %f", recognizer.rotation);
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    [recognizer setRotation:0];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    NSLog(@"scale >>>>> %f", recognizer.scale);
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    [recognizer setScale:1];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    NSLog(@"translation >>>>> %@", NSStringFromCGPoint(translation));
    // recognizer.view.transform = CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y);
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];

//    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        CGPoint velocity = [recognizer velocityInView:self.view];
//        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
//        CGFloat slideMult = magnitude / 200;
//        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
//
//        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
//        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
//                                         recognizer.view.center.y + (velocity.y * slideFactor));
//        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
//        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
//
//        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            recognizer.view.center = finalPoint;
//        } completion:nil];
//    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"oooooooooooooooooooooooo");
    NSLog(@"gestureRecognizer >>> %@", gestureRecognizer);
    NSLog(@"otherGestureRecognizer >>>>> %@", otherGestureRecognizer);
//    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
//        return NO;
//    }
    return YES;
}

@end
