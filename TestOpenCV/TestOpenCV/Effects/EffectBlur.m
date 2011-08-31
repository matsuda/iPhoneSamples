//
//  EffectBlur.m
//  TestOpenCV
//
//  Created by Kosuke Matsuda on 11/08/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EffectBlur.h"


@implementation EffectBlur

- (UIImage *)imageWithEffect:(UIImage *)image
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	IplImage *srcImg = [IplImageUtil CreateIplImageFromUIImage:image];
    IplImage *dstImg = cvCloneImage(srcImg);
    cvSmooth(srcImg, dstImg, CV_GAUSSIAN, 5, 0, 0, 0);

	// 表示
	UIImage *effectedImage = [[IplImageUtil UIImageFromIplImage:dstImg] retain];
	cvReleaseImage(&srcImg);
	cvReleaseImage(&dstImg);

    [pool release];

    return [effectedImage autorelease];
}

@end
