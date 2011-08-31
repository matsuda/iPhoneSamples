//
//  EffectSepia.m
//  TestOpenCV
//
//  Created by Kosuke Matsuda on 11/08/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EffectSepia.h"


@implementation EffectSepia

- (UIImage *)imageWithColor:(UIImage *)image red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue gray:(NSInteger)gray;
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	IplImage *srcImg = [IplImageUtil CreateIplImageFromUIImage:image];
	// IplImage *srcImg = [IplImageUtil CreateIplImageFromUIImage:image];
	IplImage *grayImg = cvCreateImage(cvGetSize(srcImg), IPL_DEPTH_8U, 1);
	IplImage *dstImg = cvCreateImage(cvGetSize(srcImg), IPL_DEPTH_8U, 3);

	// グレースケール化
	cvCvtColor(srcImg, grayImg, CV_RGB2GRAY);
	cvReleaseImage(&srcImg);

	for (int y = 0; y < grayImg->height; y++) {
		for (int x = 0; x < grayImg->width; x++){
			int g = PIXVAL(grayImg, x, y) + gray;
			PIXVAL(grayImg, x, y) = (g > 255) ? 255 : ( (g < 0) ? 0 : g );
		}
	}

	cvCvtColor(grayImg, dstImg, CV_GRAY2RGB);
	// セピア色をつける
	for (int y = 0; y < dstImg->height; y++){
		for (int x = 0; x < dstImg->width; x++){
			int r = PIXVALR(dstImg, x, y) + red;
			int g = PIXVALG(dstImg, x, y) + green;
			int b = PIXVALB(dstImg, x, y) + blue;
			PIXVALR(dstImg, x, y) = (r > 255) ? 255 : ( (r < 0) ? 0 : r );
			PIXVALG(dstImg, x, y) = (g > 255) ? 255 : ( (g < 0) ? 0 : g );
			PIXVALB(dstImg, x, y) = (b > 255) ? 255 : ( (b < 0) ? 0 : b );
		}
	}
	cvReleaseImage(&grayImg);

    IplImage *rectImg = cvCloneImage(dstImg);

    // BLUR
//    CvRect roi = cvRect(50, 50, 100, 100);
//    cvSetImageROI (dstImg, roi);
//    cvSetImageROI (rectImg, roi);
//    cvSmooth(dstImg, rectImg, CV_BLUR, 5, 0, 0, 0);

	// 表示
	UIImage *effectedImage = [[IplImageUtil UIImageFromIplImage:rectImg] retain];
	cvReleaseImage(&dstImg);
	cvReleaseImage(&rectImg);

	[pool release];

    return [effectedImage autorelease];
}

@end
