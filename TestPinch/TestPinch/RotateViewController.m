//
//  RotateViewController.m
//  TestPinch
//
//  Created by matsuda on 12/07/23.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "RotateViewController.h"

@interface RotateViewController ()
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end

@implementation RotateViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

// http://stackoverflow.com/questions/3931606/rotate-the-image-corresponding-to-the-touch-drag-in-iphone
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        if ( CGRectContainsPoint(self.view.frame, [touch locationInView:self.imageView]) ) {
            [self transformSpinnerwithTouches:touch];
        }
    }
}

- (void)transformSpinnerwithTouches:(UITouch *)touchLocation
{
    CGPoint touchLocationPoint = [touchLocation locationInView:self.view];
    CGPoint previousTouchLocationPoint = [touchLocation previousLocationInView:self.view];
    CGPoint origin = _imageView.center;
    NSLog(@"currentTouch Touch In Location In View:%@\n", NSStringFromCGPoint(touchLocationPoint));
    NSLog(@"currentTouch Touch previous Location In View:%@\n", NSStringFromCGPoint(previousTouchLocationPoint));
    CGPoint previousDifference = [self vectorFromPoint:origin toPoint:previousTouchLocationPoint];
    CGFloat previousRotation = atan2(previousDifference.y, previousDifference.x);

    CGPoint currentDifference = [self vectorFromPoint:origin toPoint:touchLocationPoint];
    CGFloat currentRotation = atan2(currentDifference.y, currentDifference.x);

    CGFloat newAngle = currentRotation - previousRotation;
    NSLog(@"currentRotation of x %F  previousRotation %F\n",currentRotation, previousRotation);
    // [_imageView.layer setAnchorPoint:_imageView.frame.origin]; // ???
//    _imageView.transform = CGAffineTransformRotate(_imageView.transform, newAngle);

    CGAffineTransform newTransform =CGAffineTransformScale(_imageView.transform, 1, 1);
    newTransform = CGAffineTransformRotate(newTransform, newAngle);
    [self animateView:_imageView toPosition:newTransform];
}

- (CGPoint)vectorFromPoint:(CGPoint)firstPoint toPoint:(CGPoint)secondPoint
{
    CGPoint result;
    CGFloat x = secondPoint.x-firstPoint.x;
    CGFloat y = secondPoint.y-firstPoint.y;
    result = CGPointMake(x, y);
    return result;
}

-(void)animateView:(UIView *)theView toPosition:(CGAffineTransform)newTransform
{
    // animating the rotator arrow...
//    [UIView setAnimationsEnabled:YES];
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.0750];
//    _imageView.transform = newTransform;
//    [UIView commitAnimations];

    [UIView animateWithDuration:0.0750
                          delay:0
                        options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         _imageView.transform = newTransform;
                     } completion:NULL];
}

@end
