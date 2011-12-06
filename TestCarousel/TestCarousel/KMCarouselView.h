//
//  KMCarouselView.h
//  TestCarousel
//
//  Created by Kosuke Matsuda on 11/12/05.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMCarouselViewDataSource.h"
#import "KMCarouselViewDelegate.h"

@protocol KMCarouselViewDataSource;
@protocol KMCarouselViewDelegate;

@interface KMCarouselView : UIView <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *items;

@property (nonatomic, assign) id<KMCarouselViewDataSource> dataSource;
@property (nonatomic, assign) id<KMCarouselViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items;

@end
