//
//  IplImageUtil.h
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  http://niw.at/articles/2009/03/14/using-opencv-on-iphone/ja
//

#import <Foundation/Foundation.h>

#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/objdetect/objdetect.hpp>


@interface IplImageUtil : NSObject {
}

+ (IplImage *)CreateIplImageFromUIImage:(UIImage *)image;
+ (UIImage *)UIImageFromIplImage:(IplImage *)image;

@end
