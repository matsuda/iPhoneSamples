//
//  SlideSegue.h
//  TestContainerController
//
//  Created by Kosuke Matsuda on 2013/01/28.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideSegue : UIStoryboardSegue {
    __weak UIView *_containerView;
}

@property (assign, nonatomic) BOOL toLeft;
@property (assign) UIViewController *delegate;

@end
