//
//  ShutterView.h
//  TestCamera
//
//  Created by Kosuke Matsuda on 2012/12/25.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShutterViewDelegate;

@interface ShutterView : UIView

@property (assign, nonatomic) id<ShutterViewDelegate> delegate;

- (void)setImage:(UIImage *)image;

@end

@protocol ShutterViewDelegate <NSObject>
- (void)didTapShutterAtShutterView:(ShutterView *)shutterView;
- (void)didTapCancelAtShutterView:(ShutterView *)shutterView;
@end
