//
//  ContainerSegue.m
//  TestContainerController
//
//  Created by Kosuke Matsuda on 2013/01/28.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import "ContainerSegue.h"

@implementation ContainerSegue

- (void)perform
{
    UIViewController *source = (UIViewController *)self.sourceViewController;
    UIViewController *destination = (UIViewController *)self.destinationViewController;
    destination.view.frame = _containerView.bounds;
    [source addChildViewController:destination];
    if ([_delegate respondsToSelector:@selector(containerSegue:didContainViewController:)]) {
        [_delegate containerSegue:self didContainViewController:destination];
    }
}

@end
