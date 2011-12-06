//
//  KMCarouselViewController.h
//  TestCarousel
//
//  Created by Kosuke Matsuda on 11/12/05.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMCarouselView.h"

@interface KMCarouselViewController : UIViewController <KMCarouselViewDataSource, KMCarouselViewDelegate>

@property (nonatomic, retain) KMCarouselView *carouselView;

@end
