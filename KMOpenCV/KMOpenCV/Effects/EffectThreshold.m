//
//  EffectThreshold.m
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EffectThreshold.h"


@implementation EffectThreshold

- (UIImage *)imageWithEffect:(UIImage *)image
{
    return [self imageWithThresholdOtsu:image];
}
- (UIImage *)imageWithThresholdOtsu:(UIImage *)image
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // (1)画像を読み込む
    IplImage *srcImg = [IplImageUtil CreateIplImageFromUIImage:image];
    IplImage *grayImg = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
    IplImage *binImg = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
	// グレースケール化
    cvCvtColor(srcImg, grayImg, CV_RGB2GRAY);
    cvReleaseImage (&srcImg);

    // (1)二値化（大津の手法を利用）
    cvThreshold (grayImg, binImg, 0, 255, CV_THRESH_BINARY | CV_THRESH_OTSU);
    cvReleaseImage (&grayImg);

    // Convert black and whilte to 24bit image then convert to UIImage to show
    IplImage *dstImg = cvCreateImage(cvGetSize(binImg), IPL_DEPTH_8U, 3);
    for(int y = 0; y < binImg->height; y++) {
        for(int x = 0; x < binImg->width; x++) {
            char *p = dstImg->imageData + y * dstImg->widthStep + x * 3;
            *p = *(p+1) = *(p+2) = binImg->imageData[y * binImg->widthStep + x];
        }
    }
//    int x, y;
//    uchar p[3];
//    for (y = 0; y < binImg->height; y++) {
//        for (x = 0; x < binImg->width; x++) {
//            /* 画素値を直接操作する一例 */
//            p[0] = binImg->imageData[binImg->widthStep * y + x * 1 + 0];    // B
//            p[1] = binImg->imageData[binImg->widthStep * y + x * 1 + 1];    // G
//            p[2] = binImg->imageData[binImg->widthStep * y + x * 1 + 2];    // R
//            dstImg->imageData[dstImg->widthStep * y + x * 3 + 0] = p[0];
//            dstImg->imageData[dstImg->widthStep * y + x * 3 + 1] = p[1];
//            dstImg->imageData[dstImg->widthStep * y + x * 3 + 2] = p[2];
//        }
//    }
    cvReleaseImage (&binImg);

    UIImage *effectedImage = [[IplImageUtil UIImageFromIplImage:dstImg] retain];
    cvReleaseImage (&dstImg);

	[pool release];

    return [effectedImage autorelease];
}

- (UIImage *)imageWithThreshold:(UIImage *)image
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // (1)画像を読み込む
    IplImage *srcImg = [IplImageUtil CreateIplImageFromUIImage:image];
    IplImage *grayImg = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
    IplImage *tmpImg = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
	// グレースケール化
    cvCvtColor(srcImg, grayImg, CV_BGR2GRAY);

    // (2)ガウシアンフィルタで平滑化を行う
    cvSmooth(grayImg, grayImg, CV_GAUSSIAN, 5, 0, 0, 0);

    // (3)二値化:cvThreshold
    cvThreshold (grayImg, tmpImg, 90, 255, CV_THRESH_BINARY);

    // Convert black and whilte to 24bit image then convert to UIImage to show
    IplImage *dstImg = cvCreateImage(cvGetSize(tmpImg), IPL_DEPTH_8U, 3);
    int x, y;
    uchar p[3];
    for (y = 0; y < tmpImg->height; y++) {
        for (x = 0; x < tmpImg->width; x++) {
            /* 画素値を直接操作する一例 */
            p[0] = tmpImg->imageData[tmpImg->widthStep * y + x * 1 + 0];    // B
            p[1] = tmpImg->imageData[tmpImg->widthStep * y + x * 1 + 1];    // G
            p[2] = tmpImg->imageData[tmpImg->widthStep * y + x * 1 + 2];    // R
            dstImg->imageData[dstImg->widthStep * y + x * 3 + 0] = p[0];
            dstImg->imageData[dstImg->widthStep * y + x * 3 + 1] = p[1];
            dstImg->imageData[dstImg->widthStep * y + x * 3 + 2] = p[2];
        }
    }

    UIImage *effectedImage = [[IplImageUtil UIImageFromIplImage:dstImg] retain];
    cvReleaseImage (&srcImg);
    cvReleaseImage (&grayImg);
    cvReleaseImage (&tmpImg);
    cvReleaseImage (&dstImg);

	[pool release];

    return [effectedImage autorelease];
}
- (UIImage *)imageWithAdaptiveThreshold:(UIImage *)image
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // (1)画像を読み込む
    IplImage *srcImg = [IplImageUtil CreateIplImageFromUIImage:image];
    IplImage *grayImg = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
    IplImage *tmpImg = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
	// グレースケール化
    cvCvtColor(srcImg, grayImg, CV_BGR2GRAY);

    // (2)ガウシアンフィルタで平滑化を行う
    cvSmooth(grayImg, grayImg, CV_GAUSSIAN, 5, 0, 0, 0);

    // (4)二値化:cvAdaptiveThreshold
    cvAdaptiveThreshold (grayImg, tmpImg, 255, CV_ADAPTIVE_THRESH_MEAN_C, CV_THRESH_BINARY, 11, 10);

    // Convert black and whilte to 24bit image then convert to UIImage to show
    IplImage *dstImg = cvCreateImage(cvGetSize(tmpImg), IPL_DEPTH_8U, 3);
    int x, y;
    uchar p[3];
    for (y = 0; y < tmpImg->height; y++) {
        for (x = 0; x < tmpImg->width; x++) {
            /* 画素値を直接操作する一例 */
            p[0] = tmpImg->imageData[tmpImg->widthStep * y + x * 1 + 0];    // B
            p[1] = tmpImg->imageData[tmpImg->widthStep * y + x * 1 + 1];    // G
            p[2] = tmpImg->imageData[tmpImg->widthStep * y + x * 1 + 2];    // R
            dstImg->imageData[dstImg->widthStep * y + x * 3 + 0] = p[0];
            dstImg->imageData[dstImg->widthStep * y + x * 3 + 1] = p[1];
            dstImg->imageData[dstImg->widthStep * y + x * 3 + 2] = p[2];
        }
    }

    UIImage *effectedImage = [[IplImageUtil UIImageFromIplImage:dstImg] retain];
    cvReleaseImage (&srcImg);
    cvReleaseImage (&grayImg);
    cvReleaseImage (&tmpImg);
    cvReleaseImage (&dstImg);

	[pool release];

    return [effectedImage autorelease];
}
- (UIImage *)imageWithThresholdMix:(UIImage *)image
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // (1)画像を読み込む
    IplImage *srcImg = [IplImageUtil CreateIplImageFromUIImage:image];
    IplImage *grayImg = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
    IplImage *tmpImg1 = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
    IplImage *tmpImg2 = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
    IplImage *tmpImg3 = cvCreateImage (cvGetSize(srcImg), IPL_DEPTH_8U, 1);
    IplImage *tmpImg4 = cvCloneImage(srcImg);
	// グレースケール化
    cvCvtColor(srcImg, grayImg, CV_BGR2GRAY);

    // (2)ガウシアンフィルタで平滑化を行う
    cvSmooth(grayImg, grayImg, CV_GAUSSIAN, 5, 0, 0, 0);

    // (3)二値化:cvThreshold
    cvThreshold (grayImg, tmpImg1, 90, 255, CV_THRESH_BINARY);

    // (4)二値化:cvAdaptiveThreshold
    cvAdaptiveThreshold (grayImg, tmpImg2, 255, CV_ADAPTIVE_THRESH_MEAN_C, CV_THRESH_BINARY, 11, 10);

    // (5)二つの二値化画像の論理積
    cvAnd (tmpImg1, tmpImg2, tmpImg3, NULL);
    cvCvtColor (tmpImg3, tmpImg4, CV_GRAY2BGR);

    // (6)元画像と二値画像の論理積
    cvSmooth (srcImg, srcImg, CV_GAUSSIAN, 11, 0, 0, 0);
    cvAnd (tmpImg4, srcImg, tmpImg4, NULL);

    // Convert black and whilte to 24bit image then convert to UIImage to show
    IplImage *dstImg = cvCreateImage(cvGetSize(tmpImg4), IPL_DEPTH_8U, 3);
    int x, y;
    uchar p[3];
    for (y = 0; y < tmpImg4->height; y++) {
        for (x = 0; x < tmpImg4->width; x++) {
            /* 画素値を直接操作する一例 */
            p[0] = tmpImg4->imageData[tmpImg4->widthStep * y + x * 1 + 0];    // B
            p[1] = tmpImg4->imageData[tmpImg4->widthStep * y + x * 1 + 1];    // G
            p[2] = tmpImg4->imageData[tmpImg4->widthStep * y + x * 1 + 2];    // R
            dstImg->imageData[dstImg->widthStep * y + x * 3 + 0] = p[0];
            dstImg->imageData[dstImg->widthStep * y + x * 3 + 1] = p[1];
            dstImg->imageData[dstImg->widthStep * y + x * 3 + 2] = p[2];
        }
    }

    UIImage *effectedImage = [[IplImageUtil UIImageFromIplImage:dstImg] retain];
    cvReleaseImage (&srcImg);
    cvReleaseImage (&grayImg);
    cvReleaseImage (&tmpImg1);
    cvReleaseImage (&tmpImg2);
    cvReleaseImage (&tmpImg3);
    cvReleaseImage (&tmpImg4);
    cvReleaseImage (&dstImg);

	[pool release];

    return [effectedImage autorelease];
}
- (UIImage *)imageWithThresholdOriginalMix:(UIImage *)image
{
    return nil;
}

@end
