//
//  UIImage+Resize.m
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Resize.h"


@implementation UIImage (Resize)

- (CGFloat)aspectRatio:(CGSize)size
{
    CGFloat widthRatio  = size.width  / self.size.width;
    CGFloat heightRatio = size.height / self.size.height;
    return (widthRatio < heightRatio) ? widthRatio : heightRatio;
}

- (CGSize)resizedSize:(CGSize)size
{
    CGFloat ratio = [self aspectRatio:size];
    return CGSizeMake(self.size.width * ratio, self.size.height * ratio);
}

- (UIImage *)resizedImage:(CGSize)size
{
    CGSize resizedSize = [self resizedSize:size];
    
    UIGraphicsBeginImageContext(resizedSize);
    
    [self drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

@end
