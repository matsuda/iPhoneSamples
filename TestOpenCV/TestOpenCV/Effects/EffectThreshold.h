//
//  EffectThreshold.h
//  TestOpenCV
//
//  Created by Kosuke Matsuda on 11/08/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EffectBase.h"

@interface EffectThreshold : EffectBase {
}

- (UIImage *)imageWithThresholdOtsu:(UIImage *)image;
- (UIImage *)imageWithThreshold:(UIImage *)image;
- (UIImage *)imageWithAdaptiveThreshold:(UIImage *)image;
- (UIImage *)imageWithThresholdMix:(UIImage *)image;
- (UIImage *)imageWithThresholdOriginalMix:(UIImage *)image;

@end
