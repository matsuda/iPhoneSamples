//
//  SlideSegue.m
//  TestContainerController
//
//  Created by Kosuke Matsuda on 2013/01/28.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "SlideSegue.h"

@implementation SlideSegue

- (void)slideAnimation
{
    __weak UIViewController *source = self.sourceViewController;
    __weak UIViewController *destination = self.destinationViewController;
    _containerView = source.view.superview;
    _containerView.clipsToBounds = YES;

    CGRect startRect = source.view.bounds;
    CGRect endRect = startRect;
    CGRect preRect = startRect;

    if (self.toLeft) {
        endRect.origin.x = source.view.bounds.origin.x - source.view.bounds.size.width;
        preRect.origin.x = source.view.bounds.origin.x + source.view.bounds.size.width;
        destination.view.frame = preRect;
    } else {
        endRect.origin.x = source.view.bounds.origin.x + source.view.bounds.size.width;
        preRect.origin.x = source.view.bounds.origin.x - source.view.bounds.size.width;
        destination.view.frame = preRect;
    }
    [_containerView addSubview:destination.view];

    [UIView transitionWithView:_containerView
                      duration:0.45f
                       options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationCurveEaseInOut)
                    animations:^{
                        source.view.frame = endRect;
                        destination.view.frame = startRect;
                    }
                    completion:^(BOOL finished){
                        [source.view removeFromSuperview];
                        if ([_delegate respondsToSelector:@selector(segueDidComplete:)]) {
                            [_delegate performSelector:@selector(segueDidComplete:) withObject:self];
                        }
                    }];
}

- (void)perform
{
    [self slideAnimation];
}

@end
