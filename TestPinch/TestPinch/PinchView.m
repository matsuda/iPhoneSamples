//
//  PinchView.m
//  TestPinch
//
//  Created by matsuda on 12/07/20.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "PinchView.h"

@interface PinchView () {
    CGFloat initialDistance;
}
@property (nonatomic, strong) NSMutableArray *touchArray;
@end

@implementation PinchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (void)initCommon
{
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
    _touchArray = [NSMutableArray array];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    for (UITouch *touch in [touches allObjects]) {
        [_touchArray addObject:touch];
    }
    NSUInteger count = [_touchArray count];
    if (count > 1) {
        UITouch *first = [_touchArray objectAtIndex:0];
        UITouch *second = [_touchArray objectAtIndex:1];
        initialDistance = distanceBetweenPoints([first locationInView:self], [second locationInView:self]);
    }
    [[self superview] bringSubviewToFront:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    NSUInteger count = [_touchArray count];
    if (count > 1) {
        UITouch *first = [_touchArray objectAtIndex:0];
        UITouch *second = [_touchArray objectAtIndex:1];
        CGFloat currentDistance = distanceBetweenPoints([first locationInView:self], [second locationInView:self]);

        if (initialDistance > 0) {
            double scale = currentDistance / initialDistance;
            CGRect f = self.frame;
            float deltaX = self.frame.size.width * (scale - 1);
            float deltaY = self.frame.size.height * (scale - 1);
            // f.size.width = _imageView.frame.size.width * scale;
            // f.size.height = _imageView.frame.size.height * scale;
            f.size.width += deltaX;
            f.size.height += deltaY;
            f.origin.x -= deltaX / 2;
            f.origin.y -= deltaY / 2;
            self.frame = f;
        }
        initialDistance = currentDistance;
    } else if (count == 1) {
        UITouch *touch = [_touchArray objectAtIndex:0];
        CGPoint loc = [touch locationInView:self];
        CGPoint prevloc = [touch previousLocationInView:self];
        CGRect f = self.frame;
        float deltaX = loc.x - prevloc.x;
        float deltaY = loc.y - prevloc.y;
        f.origin.x += deltaX;
        f.origin.y += deltaY;
        self.frame = f;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    for (UITouch *touch in [touches allObjects]) {
        NSUInteger idx = [_touchArray indexOfObject:touch];
        if (idx != NSNotFound) {
            [_touchArray removeObjectAtIndex:idx];
        }
    }
    initialDistance = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    for (UITouch *touch in [touches allObjects]) {
        NSUInteger idx = [_touchArray indexOfObject:touch];
        if (idx != NSNotFound) {
            [_touchArray removeObjectAtIndex:idx];
        }
    }
    initialDistance = 0;
}

@end
