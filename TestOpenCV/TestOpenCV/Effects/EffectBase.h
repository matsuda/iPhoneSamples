//
//  EffectBase.h
//  TestOpenCV
//
//  Created by Kosuke Matsuda on 11/08/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IplImageUtil.h"

#define PIXVAL(iplimagep, x, y) (*(uchar *)((iplimagep)->imageData + (y) * (iplimagep)->widthStep + (x)))
#define PIXVALB(iplimagep, x, y) (*(uchar *)((iplimagep)->imageData + (y) * (iplimagep)->widthStep + (x)*3+0))
#define PIXVALG(iplimagep, x, y) (*(uchar *)((iplimagep)->imageData + (y) * (iplimagep)->widthStep + (x)*3+1))
#define PIXVALR(iplimagep, x, y) (*(uchar *)((iplimagep)->imageData + (y) * (iplimagep)->widthStep + (x)*3+2))


@interface EffectBase : NSObject {
}

- (UIImage *)imageWithEffect:(UIImage *)image;

@end
