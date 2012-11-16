//
//  SequentialViewController.m
//  TestCoreAnimation
//
//  Created by Kosuke Matsuda on 2012/11/16.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "SequentialViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SequentialViewController () {
    BOOL _isShowCaption;
    BOOL _isAnimation;
}
@property (strong, nonatomic) CALayer *layer;
@end

@implementation SequentialViewController

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
    [self addCaptionlayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addCaptionlayer
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    layer.frame = CGRectMake(-200, 200, 200, 1);
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    NSLog(@"layer.position >>>>>>>>>>>> %@", NSStringFromCGPoint(layer.position));
    _isShowCaption = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isAnimation) return;

    if (_isShowCaption) {
        [self scaleNegative];
    } else {
        [self translationPositive];
    }
}

- (void)translationPositive
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.delegate = self;
    anim.values = @[
        [NSValue valueWithCATransform3D:CATransform3DIdentity],
        [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(280, 1, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(260, 1, 1)]
    ];
    anim.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:0.34f], [NSNumber numberWithFloat:1.f]];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:anim forKey:@"translationPositive"];
}

- (void)translationNegative
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.delegate = self;
    anim.values = @[
        [NSValue valueWithCATransform3D:CATransform3DIdentity],
        [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(20, 1, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-200, 1, 1)]
    ];
    anim.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:1.f]];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:anim forKey:@"translationNegative"];
}

- (void)scalePositive
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.delegate = self;
    anim.values = @[
        [NSValue valueWithCATransform3D:CATransform3DIdentity],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 120, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 100, 1)]
    ];
    anim.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:1.f]];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:anim forKey:@"scalePositive"];
}

- (void)scaleNegative
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.delegate = self;
    anim.values = @[
//        [NSValue valueWithCATransform3D:CATransform3DIdentity],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 100, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 120, 1)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)]
    ];
    anim.keyTimes = @[[NSNumber numberWithFloat:0.f], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:1.f]];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:anim forKey:@"scaleNegative"];
}

//- (void)translationPositive
//{
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
//    anim.delegate = self;
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 200.5)];
//    anim.duration = 0.2;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    [self.layer addAnimation:anim forKey:@"translationPositive"];
//}

//- (void)translationNegative
//{
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
//    anim.delegate = self;
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(-100, 200.5)];
//    anim.duration = 0.2;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    [self.layer addAnimation:anim forKey:@"translationNegative"];
//}

//- (void)scalePositive
//{
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
//    anim.delegate = self;
//    anim.toValue = [NSNumber numberWithFloat:100];
//    anim.duration = 0.2;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    [self.layer addAnimation:anim forKey:@"scalePositive"];
//}
//
//- (void)scaleNegative
//{
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
//    anim.delegate = self;
//    anim.toValue = [NSNumber numberWithFloat:1];
//    anim.duration = 0.2;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    [self.layer addAnimation:anim forKey:@"scaleNegative"];
//}

- (void)animationDidStart:(CAAnimation *)anim
{
    APPLog;
    _isAnimation = YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    APPLog;
    NSLog(@"before animationKeys >>> %@", self.layer.animationKeys);
    if ([anim isEqual:[self.layer animationForKey:@"translationPositive"]]) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        self.layer.position = CGPointMake(160, 200.5);
        [CATransaction commit];
        [self.layer removeAnimationForKey:@"translationPositive"];
        [self scalePositive];
    }
    if ([anim isEqual:[self.layer animationForKey:@"scalePositive"]]) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//        CGRect f = self.layer.frame;
//        f.origin.y = 150;
//        f.size.height = 100;
//        self.layer.frame = f;
        [self.layer setValue:[NSNumber numberWithFloat:100] forKeyPath:@"transform.scale.y"];
        [CATransaction commit];
        [self.layer removeAnimationForKey:@"scalePositive"];
        _isShowCaption = YES;
    }
    if ([anim isEqual:[self.layer animationForKey:@"scaleNegative"]]) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//        CGRect f = self.layer.frame;
//        f.origin.y = 200;
//        f.size.height = 1;
//        self.layer.frame = f;
        [self.layer setValue:[NSNumber numberWithFloat:1] forKeyPath:@"transform.scale.y"];
        [CATransaction commit];
        [self.layer removeAnimationForKey:@"scaleNegative"];
        [self translationNegative];
    }
    if ([anim isEqual:[self.layer animationForKey:@"translationNegative"]]) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        self.layer.position = CGPointMake(-100, 200.5);
        [CATransaction commit];
        [self.layer removeAnimationForKey:@"translationNegative"];
        _isShowCaption = NO;
    }
    NSLog(@"layer frame >>>>> %@", NSStringFromCGRect(self.layer.frame));
    NSLog(@"layer position >>>>> %@", NSStringFromCGPoint(self.layer.position));
    NSLog(@"after animationKeys >>> %@", self.layer.animationKeys);
    _isAnimation = NO;
}

@end
