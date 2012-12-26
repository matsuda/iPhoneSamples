//
//  ShutterView.m
//  TestAV
//
//  Created by Kosuke Matsuda on 2012/12/26.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ShutterView.h"

@interface ShutterView ()
@end

@implementation ShutterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    [self setNeedsDisplay];
}

- (IBAction)pushShutter:(UIButton *)sender
{
    [self.delegate didPushShutterAtShutterView:self];
}

@end
