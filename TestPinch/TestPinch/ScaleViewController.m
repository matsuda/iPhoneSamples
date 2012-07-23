//
//  ScaleViewController.m
//  TestPinch
//
//  Created by matsuda on 12/07/23.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ScaleViewController.h"

@interface ScaleViewController ()
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end

@implementation ScaleViewController

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

    CGFloat currentDistance = distanceBetweenPoints(origin, touchLocationPoint);
    CGFloat previousDistance = distanceBetweenPoints(origin, previousTouchLocationPoint);
    double scale = currentDistance / previousDistance;

    CGAffineTransform newTransform =CGAffineTransformScale(_imageView.transform, scale, scale);
//    [self animateView:_imageView toPosition:newTransform];
    _imageView.transform = newTransform;
}

-(void)animateView:(UIView *)theView toPosition:(CGAffineTransform)newTransform
{
    // animating the rotator arrow...
    [UIView animateWithDuration:0.0750
                          delay:0
                        options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         _imageView.transform = newTransform;
                     } completion:NULL];
}

@end
