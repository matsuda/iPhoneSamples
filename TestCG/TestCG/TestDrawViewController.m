//
//  TestDrawViewController.m
//  TestCG
//
//  Created by matsuda on 12/06/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*
 http://www.atmarkit.co.jp/fsmart/articles/iphonesdk05/01.html
 */
#import "TestDrawViewController.h"

@interface TestDrawViewController () {
    UIImageView *_canvas;
    CGPoint _touchPoint;
}

@end

@implementation TestDrawViewController

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
    _canvas = [[UIImageView alloc] initWithImage:nil];
    _canvas.backgroundColor = [UIColor whiteColor];
    _canvas.frame = self.view.frame;
    [self.view insertSubview:_canvas atIndex:0];

    UIBarButtonItem *trashButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearCanvas)];
    self.navigationItem.rightBarButtonItem = trashButton;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:_canvas];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:_canvas];

    UIGraphicsBeginImageContext(_canvas.frame.size);
    [_canvas.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(_canvas.frame), CGRectGetHeight(_canvas.frame))];

    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(c, kCGLineCapRound);
    CGContextSetLineWidth(c, 10.0);
    CGContextSetRGBStrokeColor(c, 0.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(c, _touchPoint.x, _touchPoint.y);
    CGContextAddLineToPoint(c, currentPoint.x, currentPoint.y);
    CGContextStrokePath(c);

    _canvas.image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    _touchPoint = currentPoint;
}

- (void)clearCanvas
{
    _canvas.image = nil;
}

@end
