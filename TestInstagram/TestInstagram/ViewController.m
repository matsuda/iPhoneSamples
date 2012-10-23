//
//  ViewController.m
//  TestInstagram
//
//  Created by matsuda on 12/07/26.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ViewController.h"

#import "MaskView.h"
#import "UIImage+Filter.h"

@interface ViewController () <MaskViewDelegate>
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIView *layerView;
@property (nonatomic, weak) MaskView *maskView;
@end

@implementation ViewController

@synthesize imageView = _imageView;
@synthesize layerView = _layerView;
@synthesize maskView = _maskView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    [self loadImageView];
//    [self loadLayerView];
    [self loadMaskView];
    self.view.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMaskView
{
    MaskView *maskView = [[MaskView alloc] initWithFrame:self.imageView.frame];
    maskView.center = self.imageView.center;
    maskView.delegate = self;
    [self.view addSubview:maskView];
    self.maskView = maskView;
}

- (void)loadImageView
{
    CGRect r = [[UIScreen mainScreen] applicationFrame];
    
    UIImage *image = [UIImage imageNamed:@"sample"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = CGPointMake(r.size.width / 2, r.size.height / 2);

    [self.view addSubview:imageView];
    self.imageView = imageView;

}

- (void)maskViewDidFinishAdjustingArea:(MaskView *)maskView
{
    CGRect ir = self.imageView.bounds;
    CGRect r = maskView.maskRect;
    NSLog(@"maskRect >>>>>>>>>>>>>>>>> %@", NSStringFromCGRect(r));

    CGPoint center = CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r));
    if (center.x < 0) {
        r.origin.x += (0 - center.x);
    } else if (center.x > CGRectGetMaxX(ir)) {
        r.origin.x -= (center.x - CGRectGetMaxX(ir));
    }
    if (center.y < 0) {
        r.origin.y += (0 - center.y);
    } else if (center.y > CGRectGetMaxY(ir)) {
        r.origin.y -= (center.y - CGRectGetMaxY(ir));
    }
//    if (r.origin.x < 0) {
//        r.origin.x = 0;
//    } else if (r.origin.x > CGRectGetMaxX(ir)) {
//        r.origin.x = CGRectGetMaxX(ir);
//    }
//    if (r.origin.y < 0) {
//        r.origin.y = 0;
//    } else if (r.origin.y > CGRectGetMaxY(ir)) {
//        r.origin.y = CGRectGetMaxY(ir);
//    }
//    if (r.origin.x + r.size.width > CGRectGetMaxX(ir)) {
//        r.size.width = CGRectGetMaxX(ir) - r.origin.x;
//    }
//    if (r.origin.y + r.size.height > CGRectGetMaxY(ir)) {
//        r.size.height = CGRectGetMaxY(ir) - r.origin.y;
//    }
    NSLog(@"after >>>>>>>>>>>>>>>> %@", NSStringFromCGRect(r));

    UIImage *image = [UIImage imageNamed:@"sample"];
//    UIImage *filteredImage = [image averageFilter:5 toRect:r];
    UIImage *filteredImage = [image gradationImage:r];
    
    self.imageView.image = filteredImage;
    [self.imageView setNeedsDisplay];
}

//- (void)loadLayerView
//{
//    CGRect f = self.imageView.frame;
//    UIView *v = [[UIView alloc] initWithFrame:f];
//    v.backgroundColor = [UIColor whiteColor];
//    v.alpha = 0.5;
//    [self.view addSubview:v];
//    self.layerView = v;
//}

@end
