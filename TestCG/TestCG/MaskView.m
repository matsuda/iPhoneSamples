//
//  MaskView.m
//  TestCG
//
//  Created by matsuda on 12/07/25.
//
//

#import "MaskView.h"

#import <CoreImage/CoreImage.h>

@interface MaskView ()
@property (nonatomic, strong) UIImage *image;
@end

@implementation MaskView

@synthesize image = _image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIImage *image = [UIImage imageNamed:@"sample"];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        [self addSubview:imageView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.image == nil) {
        UIImage *image = [UIImage imageNamed:@"sample"];
//        UIImage *mask = [self convertGrayScaleImage:[UIImage imageNamed:@"mask"]];
//        mask = [self blur:mask];
//        UIImage *mask = [UIImage imageNamed:@"mask"];
//        UIImage *maskedImage = [self maskImage:image withMask:mask];
//        UIImage *maskedImage = [UIImage imageNamed:@"test"];
//        UIImage *blurImage = [self blur:image];
//        UIImage *mixedImage = [self mixtureImage:blurImage withImage:maskedImage];
        self.image = image;
    }
    [self.image drawInRect:self.bounds];
}

- (UIImage *)mixtureImage:(UIImage *)image withImage:(UIImage *)otherImage
{
    CGImageRef cgImage = image.CGImage;
    CGImageRef cgImage2 = otherImage.CGImage;
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);

//    CGContextRef context = CGBitmapContextCreate(nil, CGImageGetWidth(cgImage), CGImageGetBitsPerComponent(cgImage), CGImageGetBitsPerComponent(cgImage), CGImageGetBytesPerRow(cgImage), CGColorSpaceCreateDeviceRGB(), kCGImageAlphaPremultipliedLast);
    CGContextRef context = [self createBitmapContextWithCGSize:image.size];

    CGContextDrawImage(context, rect, cgImage2);
    CGContextDrawImage(context, rect, cgImage);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);

    UIImage *mixtureImage = [UIImage imageWithCGImage:imageRef];

    CGImageRelease(imageRef);
    CGContextRelease(context);

    return mixtureImage;
}

-(CGContextRef)createBitmapContextWithCGSize:(CGSize)size
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    bitmapBytesPerRow   = (size.width * 4);// 1
    bitmapByteCount     = (bitmapBytesPerRow * size.height);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();// 2
    bitmapData = malloc( bitmapByteCount );// 3
    if (bitmapData == NULL)
    {
        NSLog(@"Memory not allocated!");
        return NULL;
    }
    context = CGBitmapContextCreate (bitmapData,// 4
                                     size.width,
                                     size.height,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    if (context== NULL)
    {
        free (bitmapData);// 5
        NSLog(@"Context not created!");
        return NULL;
    }
    CGColorSpaceRelease( colorSpace );// 6
    
    return context;// 7
}

- (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], maskRef);
    return [UIImage imageWithCGImage:masked];
}

//- (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage
//{
//    CGImageRef maskRef = maskImage.CGImage;
//
//    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
//                                        CGImageGetHeight(maskRef),
//                                        CGImageGetBitsPerComponent(maskRef),
//                                        CGImageGetBitsPerPixel(maskRef),
//                                        CGImageGetBytesPerRow(maskRef),
//                                        CGImageGetDataProvider(maskRef), NULL, false);
//
//    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
//    return [UIImage imageWithCGImage:masked];
//}

- (UIImage *)convertGrayScaleImage:(UIImage *)image
{
    CGImageRef cgImage = image.CGImage;
    size_t width;
    size_t height;
    size_t bitsPerComponent;
    // size_t bitsPerPixel;
    size_t bytesPerRow;
    CGColorSpaceRef colorSpace;
    CGBitmapInfo bitmapInfo;

    width = image.size.width;
    height = image.size.height;
    bitsPerComponent = 8;
    bytesPerRow = 0;
    colorSpace = CGColorSpaceCreateDeviceGray();
    bitmapInfo = kCGImageAlphaNone;

    CGRect rect = CGRectMake(0, 0, width, height);

    // alpha
    CGContextRef alphaContext = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaOnly);
    CGContextDrawImage(alphaContext, rect, cgImage);
    CGImageRef alphaRef = CGBitmapContextCreateImage(alphaContext);
    CGContextRelease(alphaContext);

    UIImage *alphaImage = [UIImage imageWithCGImage:alphaRef];
    CGImageRelease(alphaRef);
    CGColorSpaceRelease(colorSpace);
    return alphaImage;

    // grayScale
    CGContextRef context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    CGContextDrawImage(context, rect, cgImage);
    CGImageRef grayScaleRef = CGBitmapContextCreateImage(context);

    CGImageRef maskImage = CGImageCreateWithMask(grayScaleRef, alphaRef);
    CGImageRelease(alphaRef);
    CGImageRelease(grayScaleRef);

    UIImage *grayScaleImage = [UIImage imageWithCGImage:maskImage];

    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGImageRelease(maskImage);

    return grayScaleImage;
}

- (UIImage *)blur:(UIImage *)image
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:1.1] forKey:@"inputRadius"];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef cgimg = [ciContext createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return tmpImage;
}

@end
