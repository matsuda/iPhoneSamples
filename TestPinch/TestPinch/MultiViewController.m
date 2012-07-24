//
//  MultiViewController.m
//  TestPinch
//
//  Created by matsuda on 12/07/23.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "MultiViewController.h"

@interface MultiViewController () {
    CGFloat initialDistance;
}
@property (nonatomic, strong) NSMutableArray *touchArray;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end

@implementation MultiViewController

@synthesize imageView = _imageView;
@synthesize touchArray = _touchArray;

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
    self.view.multipleTouchEnabled = YES;
    _touchArray = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    for (UITouch *touch in [touches allObjects]) {
        [_touchArray addObject:touch];
    }
    NSUInteger count = [_touchArray count];
    if (count > 1) {
        UITouch *first = [_touchArray objectAtIndex:0];
        UITouch *second = [_touchArray objectAtIndex:1];
        CGPoint firstLocation = [first locationInView:self.view];
        CGPoint secondLocation = [second locationInView:self.view];
        initialDistance = distanceBetweenPoints(firstLocation, secondLocation);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    NSUInteger count = [_touchArray count];
    if (count > 1) {
        UITouch *first = [_touchArray objectAtIndex:0];
        UITouch *second = [_touchArray objectAtIndex:1];
        CGPoint firstLocation = [first locationInView:self.view];
        CGPoint secondLocation = [second locationInView:self.view];
        CGFloat currentDistance = distanceBetweenPoints(firstLocation, secondLocation);

        if ( CGRectContainsPoint(_imageView.frame, firstLocation) ) {

            if (initialDistance > 0) {
                double scale = currentDistance / initialDistance;
                CGAffineTransform newTransform = CGAffineTransformMakeScale(scale, scale);

                CGPoint touchLocationPoint = [second locationInView:self.view];
                CGPoint previousTouchLocationPoint = [second previousLocationInView:self.view];
                CGPoint origin = _imageView.center;
                // CGPoint origin = [first locationInView:self.view];
                CGPoint previousDifference = [self vectorFromPoint:origin toPoint:previousTouchLocationPoint];
                CGFloat previousRotation = atan2(previousDifference.y, previousDifference.x);

                CGPoint currentDifference = [self vectorFromPoint:origin toPoint:touchLocationPoint];
                CGFloat currentRotation = atan2(currentDifference.y, currentDifference.x);

                CGFloat newAngle = currentRotation - previousRotation;
                CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(newAngle);

                newTransform = CGAffineTransformConcat(newTransform, rotateTransform);
                _imageView.transform = CGAffineTransformConcat(_imageView.transform, newTransform);
            }
        }

        initialDistance = currentDistance;
    } else if (count == 1) {
        UITouch *touch = [_touchArray objectAtIndex:0];
        CGPoint loc = [touch locationInView:self.view];
        CGPoint prevloc = [touch previousLocationInView:self.view];

        if ( CGRectContainsPoint(_imageView.frame, loc) ) {
            CGPoint currentDifference = [self vectorFromPoint:prevloc toPoint:loc];
            CGAffineTransform newTransform = CGAffineTransformMakeTranslation(currentDifference.x, currentDifference.y);
            _imageView.transform = CGAffineTransformConcat(_imageView.transform, newTransform);
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    for (UITouch *touch in [touches allObjects]) {
        NSUInteger idx = [_touchArray indexOfObject:touch];
        if (idx != NSNotFound) {
            [_touchArray removeObjectAtIndex:idx];
        }
    }
    initialDistance = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    for (UITouch *touch in [touches allObjects]) {
        NSUInteger idx = [_touchArray indexOfObject:touch];
        if (idx != NSNotFound) {
            [_touchArray removeObjectAtIndex:idx];
        }
    }
    initialDistance = 0;
}

- (CGPoint)vectorFromPoint:(CGPoint)firstPoint toPoint:(CGPoint)secondPoint
{
    CGPoint result;
    CGFloat x = secondPoint.x - firstPoint.x;
    CGFloat y = secondPoint.y - firstPoint.y;
    result = CGPointMake(x, y);
    return result;
}

- (CGPoint)anchorPointInTouch:(UITouch *)aTouch insideView:(UIView *)view
{
    CGPoint p = [aTouch locationInView:view];
    CGSize s = self.imageView.bounds.size;
    float x, y;

    if (p.x < 0) {
        x = 0;
    } else if (p.x > s.width) {
        x = s.width;
    } else {
        x = p.x;
    }

    if (p.y < 0) {
        y = 0;
    } else if (p.y > s.height) {
        y = s.height;
    } else {
        y = p.y;
    }
    return CGPointMake(x / s.width, y / s.height);
}

@end
