//
//  UIImage+Resize.h
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (Resize)
- (CGFloat)aspectRatio:(CGSize)size;
- (CGSize)resizedSize:(CGSize)size;
- (UIImage *)resizedImage:(CGSize)size;
@end
