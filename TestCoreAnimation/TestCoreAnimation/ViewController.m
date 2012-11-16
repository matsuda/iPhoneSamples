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
//    [self rotateAnimation];
//    [self blinkAnimation];
//    [self rollingAnimation];
    [self translationAnimation];
}

- (void)translationAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2f;
    animation.values = @[
        [NSValue valueWithCATransform3D:CATransform3DIdentity],
        [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(100, 0, 0)],
        [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(80, 0, 0)]
    ];
    animation.keyTimes = @[[NSNumber numberWithFloat:0], [NSNumber numberWithFloat:0.45], [NSNumber numberWithFloat:1]];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"translation"];
}

- (void)rollingAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1.0;
//    animation.repeatCount = FLT_MAX;
    animation.values = @[
        [NSValue valueWithCATransform3D:CATransform3DIdentity],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * 90 / 180.f, 0, 0, 1.f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * 180 / 180.f, 0, 0, 1.f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * 270 / 180.f, 0, 0, 1.f)],
        [NSValue valueWithCATransform3D:CATransform3DIdentity]
    ];
    [self.layer addAnimation:animation forKey:@"rollingAnimation"];
}

- (void)blinkAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 2.0f;
    animation.repeatCount = FLT_MAX;
    animation.values = @[[NSNumber numberWithFloat:1.f], [NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:1.f]];
    [self.layer addAnimation:animation forKey:@"blinkAnimation"];
}

- (void)rotateAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.2;
    animation.repeatCount = FLT_MAX;
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
