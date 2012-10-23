//
//  MaskView.h
//  TestInstagram
//
//  Created by matsuda on 12/07/26.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MaskViewDelegate;

@interface MaskView : UIView

@property (nonatomic) CGRect maskRect;
@property (nonatomic) id<MaskViewDelegate> delegate;
@end

@protocol MaskViewDelegate <NSObject>
@optional
- (void)maskViewDidFinishAdjustingArea:(MaskView *)maskView;
@end
