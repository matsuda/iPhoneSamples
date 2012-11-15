//
//  ViewController.m
//  TestCoreAnimation
//
//  Created by Kosuke Matsuda on 2012/11/15.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (strong, nonatomic) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self addBaseLayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBaseLayer
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(160, 200);
    [self.view.layer addSublayer:layer];
    self.layer = layer;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
//    [self fadeAnimation];
    [self rotateAnimation];
}

- (void)rotateAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1.f;
    animation.toValue = [NSNumber numberWithFloat:(M_PI / 180) * 90];
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"rotateAnimation"];
}

- (void)fadeAnimation
{
    CALayer *layer = self.layer;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 1.0;
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [layer addAnimation:animation forKey:@"faceAnimation"];
}

@end
