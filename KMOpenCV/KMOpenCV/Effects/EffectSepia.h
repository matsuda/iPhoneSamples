//
//  EffectSepia.h
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EffectBase.h"

@interface EffectSepia : EffectBase {
}

- (UIImage *)imageWithColor:(UIImage *)image red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue gray:(NSInteger)gray;

@end
