//
//  KMCarouselViewDelegate.h
//  TestCarousel
//
//  Created by Kosuke Matsuda on 11/12/05.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMCarouselView.h"

@class KMCarouselView;

@protocol KMCarouselViewDelegate <NSObject>
@optional
- (void)carouselView:(KMCarouselView *)carouselView didSelectItemAtIndex:(NSInteger)index;
@end
