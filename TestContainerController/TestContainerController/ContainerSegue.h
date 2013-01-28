//
//  ContainerSegue.h
//  TestContainerController
//
//  Created by Kosuke Matsuda on 2013/01/28.
//  Copyright (c) 2013年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContainerSegueDelegate;

@interface ContainerSegue : UIStoryboardSegue

@property (weak, nonatomic) UIView *containerView;
@property (weak ,nonatomic) id <ContainerSegueDelegate> delegate;

@end

@protocol ContainerSegueDelegate <NSObject>
@optional
- (void)containerSegue:(ContainerSegue *)segue didContainViewController:(UIViewController *)controller;
@end
