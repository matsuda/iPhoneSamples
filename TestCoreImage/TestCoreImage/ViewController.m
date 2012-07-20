//
//  ViewController.m
//  TestCoreImage
//
//  Created by matsuda on 12/07/19.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ViewController.h"

#import <CoreImage/CoreImage.h>

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *baseImageView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

@synthesize baseImageView;
@synthesize imageView = _imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupImageView
{
    UIImage *image = [UIImage imageNamed:@"test"];
    image = [self sepia:image];
//    image = [self monochrome:image];
    _imageView.image = image;
}

- (UIImage *)colorCube:(UIImage *)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIColorCube"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];

//    uint8_t color_cube_data[4096*4] = {
//        
//    };
//    NSData *data = [NSData dataWithBytes:color_cube_data length:4096*sizeof(float)*4];
//    [filter setValue:data forKey:@"inputCubeData"];

//    [filter setValue:[NSNumber numberWithFloat:16] forKey:@"inputCubeDimension"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [ciContext createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return tmpImage;
}

- (UIImage *)gloom:(UIImage *)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGloom"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    // [filter setValue:[NSNumber numberWithFloat:50.0] forKey:@"inputRadius"];
    // [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputIntensity"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [ciContext createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return tmpImage;
}

- (UIImage *)colorControls:(UIImage *)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputSaturation"];
    [filter setValue:[NSNumber numberWithFloat:-0.1] forKey:@"inputBrightness"];
    [filter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputContrast"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [ciContext createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return tmpImage;
}

- (UIImage *)whitePointAdjust:(UIImage *)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIWhitePointAdjust"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:[CIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.f] forKey:@"inputColor"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [ciContext createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return tmpImage;
}

- (UIImage *)monochrome:(UIImage *)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputIntensity"];
    [filter setValue:[CIColor colorWithRed:0.3 green:0.5 blue:0.7 alpha:1.f] forKey:@"inputColor"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [ciContext createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return tmpImage;
}

- (UIImage *)sepia:(UIImage *)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext contextWithOptions:nil];

    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, ciImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];

    CGImageRef cgimg = [ciContext createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    return tmpImage;
}

- (UIImage *)blur:(UIImage *)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:1.8] forKey:@"inputRadius"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [ciContext createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return tmpImage;
}

- (UIImage *)sharp:(UIImage *)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIUnsharpMask"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:3.0] forKey:@"inputRadius"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [ciContext createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return tmpImage;
}


- (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef), CGImageGetHeight(maskRef), CGImageGetBitsPerComponent(maskRef), CGImageGetBitsPerPixel(maskRef), CGImageGetBytesPerRow(maskRef), CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
}

@end
