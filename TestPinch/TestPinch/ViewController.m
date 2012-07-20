//
//  ViewController.m
//  TestPinch
//
//  Created by matsuda on 12/07/20.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ViewController.h"

CGFloat distanceBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
}

@interface ViewController () {
    CGFloat initialDistance;
}
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *touchArray;
@end

@implementation ViewController

@synthesize imageView = _imageView;
@synthesize touchArray = _touchArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
        initialDistance = distanceBetweenPoints([first locationInView:self.view], [second locationInView:self.view]);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    NSUInteger count = [_touchArray count];
    if (count > 1) {
        UITouch *first = [_touchArray objectAtIndex:0];
        UITouch *second = [_touchArray objectAtIndex:1];
        CGFloat currentDistance = distanceBetweenPoints([first locationInView:self.view], [second locationInView:self.view]);

        if (initialDistance > 0) {
            double scale = currentDistance / initialDistance;
            CGRect f = _imageView.frame;
            float deltaX = _imageView.frame.size.width * (scale - 1);
            float deltaY = _imageView.frame.size.height * (scale - 1);
            // f.size.width = _imageView.frame.size.width * scale;
            // f.size.height = _imageView.frame.size.height * scale;
            f.size.width += deltaX;
            f.size.height += deltaY;
            f.origin.x -= deltaX / 2;
            f.origin.y -= deltaY / 2;
            _imageView.frame = f;
        }
        initialDistance = currentDistance;
    } else if (count == 1) {
        UITouch *touch = [_touchArray objectAtIndex:0];
        CGPoint loc = [touch locationInView:self.view];
        CGPoint prevloc = [touch previousLocationInView:self.view];
        CGRect f = _imageView.frame;
        float deltaX = loc.x - prevloc.x;
        float deltaY = loc.y - prevloc.y;
        f.origin.x += deltaX;
        f.origin.y += deltaY;
        _imageView.frame = f;
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

@end
