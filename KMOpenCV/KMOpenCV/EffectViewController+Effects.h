//
//  EffectViewController+Effects.h
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EffectViewController.h"

@interface EffectViewController (Effects)

- (void)setActionToButton:(UIButton *)button index:(int)index;
- (void)doEffectColorRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue gray:(NSInteger)gray;
- (void)doEffectThreshold;
- (void)doEffectBlur;

@end
