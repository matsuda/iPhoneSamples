//
//  EffectViewController.h
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PhotoViewController.h"

@interface EffectViewController : PhotoViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView_;
}

@property (nonatomic, retain) UIScrollView *scrollView;

@end
