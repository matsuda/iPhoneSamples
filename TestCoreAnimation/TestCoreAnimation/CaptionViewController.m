//
//  CaptionViewController.m
//  TestCoreAnimation
//
//  Created by Kosuke Matsuda on 2012/11/15.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "CaptionViewController.h"
#import <QuartzCore/QuartzCore.h>

#define APPLog NSLog(@"%s", __func__)

@interface CaptionViewController () {
    BOOL _isShowCaption;
    BOOL _isAnimation;
}
@property (strong, nonatomic) CALayer *layer;
@end

@implementation CaptionViewController

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
        [self hideCaption];
    } else {
        [self showCaption];
    }
}

- (void)showCaption
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.delegate = self;
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(160, 200.5)];
    anim.duration = 0.2;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    // アニメーション後に状態を保持させる方法
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    // [self.layer addAnimation:anim forKey:@"moveHorisontal"];

    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    anim2.delegate = self;
    anim2.toValue = [NSNumber numberWithFloat:100];
    anim2.beginTime = anim.beginTime + anim.duration;
    anim2.duration = 0.2;
    anim2.removedOnCompletion = NO;
    anim2.fillMode = kCAFillModeForwards;
    // [self.layer setValue:[NSNumber numberWithFloat:2] forKeyPath:@"transform.scale.y"];
    // [self.layer addAnimation:anim2 forKey:@"scaleTransform"];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = anim2.beginTime + anim2.duration;
    group.animations = [NSArray arrayWithObjects:anim, anim2, nil];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:group forKey:@"showCaptionAnimations"];
}

- (void)hideCaption
{
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    anim2.delegate = self;
    anim2.toValue = [NSNumber numberWithFloat:1];
    anim2.duration = 0.2;
    anim2.removedOnCompletion = NO;
    anim2.fillMode = kCAFillModeForwards;
    // [self.layer setValue:[NSNumber numberWithFloat:2] forKeyPath:@"transform.scale.y"];
    // [self.layer addAnimation:anim2 forKey:@"scaleTransform"];

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.delegate = self;
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(-100, 200.5)];
    anim.beginTime = anim2.beginTime + anim2.duration;
    anim.duration = 0.1;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    // アニメーション後に状態を保持させる方法
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    // [self.layer addAnimation:anim forKey:@"moveHorisontal"];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = anim.beginTime + anim.duration;
    group.animations = [NSArray arrayWithObjects:anim2, anim, nil];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:group forKey:@"hideCaptionAnimations"];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    APPLog;
    _isAnimation = YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    APPLog;
    if (_isShowCaption) {
        _isShowCaption = NO;
        [self.layer removeAnimationForKey:@"showCaptionAnimations"];
        [self.layer removeAnimationForKey:@"hideCaptionAnimations"];
    } else {
        _isShowCaption = YES;
    }
    NSLog(@"layer frame >>>>> %@", NSStringFromCGRect(self.layer.frame));
    NSLog(@"layer position >>>>> %@", NSStringFromCGPoint(self.layer.position));
    NSLog(@"animationKeys >>> %@", self.layer.animationKeys);
    _isAnimation = NO;
}

@end
