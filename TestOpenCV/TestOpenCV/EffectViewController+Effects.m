//
//  EffectViewController+Effects.m
//  TestOpenCV
//
//  Created by Kosuke Matsuda on 11/08/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EffectViewController+Effects.h"

#import "EffectSepia.h"
#import "EffectThreshold.h"
#import "EffectBlur.h"

@implementation EffectViewController (Effects)

- (void)showAlertNotPhoto
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"photo" message:@"choice photos" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)setActionToButton:(UIButton *)button index:(int)index
{
    switch (index) {
        case 0:
            [button addTarget:self action:@selector(doEffectA) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [button addTarget:self action:@selector(doEffectB) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            [button addTarget:self action:@selector(doEffectC) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 5:
            [button addTarget:self action:@selector(doEffectThresholdA) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 6:
            [button addTarget:self action:@selector(doEffectThresholdB) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 7:
            [button addTarget:self action:@selector(doEffectThresholdC) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 8:
            [button addTarget:self action:@selector(doEffectThreshold) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 9:
            [button addTarget:self action:@selector(doEffectBlur) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
}

- (void)doEffectColorRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue gray:(NSInteger)gray
{
	if (!imageView_.image) {
        [self showAlertNotPhoto];
        return;
    }

    EffectSepia *effect = [[[EffectSepia alloc] init] autorelease];
    UIImage *image = [effect imageWithColor:self.originalImage red:red green:green blue:blue gray:gray];
    imageView_.image = image;
}
- (void)doEffectA
{
    [self doEffectColorRed:-60 green:0 blue:50 gray:50];
}
- (void)doEffectB
{
    [self doEffectColorRed:-73 green:-57 blue:-5 gray:35];
}
- (void)doEffectC
{
    [self doEffectColorRed:-57 green:-57 blue:-57 gray:0];
}
- (void)doEffectThresholdA
{
	if (!imageView_.image) {
        [self showAlertNotPhoto];
        return;
    }

    EffectThreshold *effect = [[[EffectThreshold alloc] init] autorelease];
    UIImage *image = [effect imageWithThreshold:self.originalImage];
    imageView_.image = image;
}
- (void)doEffectThresholdB
{
	if (!imageView_.image) {
        [self showAlertNotPhoto];
        return;
    }

    EffectThreshold *effect = [[[EffectThreshold alloc] init] autorelease];
    UIImage *image = [effect imageWithAdaptiveThreshold:self.originalImage];
    imageView_.image = image;
}
- (void)doEffectThresholdC
{
	if (!imageView_.image) {
        [self showAlertNotPhoto];
        return;
    }

    EffectThreshold *effect = [[[EffectThreshold alloc] init] autorelease];
    UIImage *image = [effect imageWithThresholdMix:self.originalImage];
    imageView_.image = image;
}
- (void)doEffectThreshold
{
	if (!imageView_.image) {
        [self showAlertNotPhoto];
        return;
    }

    EffectThreshold *effect = [[[EffectThreshold alloc] init] autorelease];
    UIImage *image = [effect imageWithEffect:self.originalImage];
    imageView_.image = image;
}
- (void)doEffectBlur
{
	if (!imageView_.image) {
        [self showAlertNotPhoto];
        return;
    }

    EffectBlur *effect = [[[EffectBlur alloc] init] autorelease];
    UIImage *image = [effect imageWithEffect:self.originalImage];
    imageView_.image = image;
}

@end
