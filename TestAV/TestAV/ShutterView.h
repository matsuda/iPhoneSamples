//
//  ShutterView.h
//  TestAV
//
//  Created by Kosuke Matsuda on 2012/12/26.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShutterViewDelegate;

@interface ShutterView : UIView

@property (assign, nonatomic) id<ShutterViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)setImage:(UIImage *)image;

@end

@protocol ShutterViewDelegate <NSObject>
- (void)didPushShutterAtShutterView:(ShutterView *)shutterView;
@end
