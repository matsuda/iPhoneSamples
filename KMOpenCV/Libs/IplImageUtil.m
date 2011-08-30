//
//  IplImageUtil.m
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IplImageUtil.h"


@implementation IplImageUtil

// NOTE 戻り値は利用後cvReleaseImage()で解放してください
+ (IplImage *)CreateIplImageFromUIImage:(UIImage *)image
{
    // CGImageをUIImageから取得
	CGImageRef imageRef = image.CGImage;

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 一時的なIplImageを作成
	IplImage *iplimage = cvCreateImage(cvSize(image.size.width, image.size.height), IPL_DEPTH_8U, 4);
    // CGContextを一時的なIplImageから作成
	CGContextRef contextRef = CGBitmapContextCreate(iplimage->imageData, iplimage->width, iplimage->height,
													iplimage->depth, iplimage->widthStep,
													colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault);
    // CGImageをCGContextに描画
	CGContextDrawImage(contextRef, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
	CGContextRelease(contextRef);
	CGColorSpaceRelease(colorSpace);

    // 最終的なIplImageを作成
	IplImage *ret = cvCreateImage(cvGetSize(iplimage), IPL_DEPTH_8U, 3);

    // modified by matsuda
	// cvCvtColor(iplimage, ret, CV_RGBA2BGR);
	cvCvtColor(iplimage, ret, CV_RGBA2RGB);

	cvReleaseImage(&iplimage);

	return ret;
}

// NOTE IplImageは事前にRGBモードにしておいてください。
+ (UIImage *)UIImageFromIplImage:(IplImage *)image
{
	NSLog(@"IplImage (%d, %d) %d bits by %d channels, %d bytes/row %s", image->width, image->height, image->depth, image->nChannels, image->widthStep, image->channelSeq);

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // CGImageのためのバッファを確保
	NSData *data = [NSData dataWithBytes:image->imageData length:image->imageSize];
	CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)data);
    // IplImageのデータからCGImageを作成
	CGImageRef imageRef = CGImageCreate(image->width, image->height,
										image->depth, image->depth * image->nChannels, image->widthStep,
										colorSpace, kCGImageAlphaNone|kCGBitmapByteOrderDefault,
										provider, NULL, false, kCGRenderingIntentDefault);
    // UIImageをCGImageから取得
	UIImage *ret = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	CGDataProviderRelease(provider);
	CGColorSpaceRelease(colorSpace);
	return ret;
}

@end
