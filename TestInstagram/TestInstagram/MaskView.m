//
//  MaskView.m
//  TestInstagram
//
//  Created by matsuda on 12/07/26.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "MaskView.h"
#import "CGPointUtil.h"

@interface MaskView () {
    CGFloat initialDistance;
    BOOL _isTached;
}
@property (nonatomic, strong) NSMutableArray *touchArray;
@end

@implementation MaskView

@synthesize maskRect = _maskRect;
@synthesize touchArray = _touchArray;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        _touchArray = [NSMutableArray array];
        _isTached = YES;
        [self maskAtDefault];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (_isTached) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.5);
        CGContextFillRect(context, self.bounds);

        [self drawMask:self.maskRect inContext:context];
    }
}

- (void)drawMask:(CGRect)rect inContext:(CGContextRef)context
{
    CGContextSaveGState(context);
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetBlendMode(context, kCGBlendModeClear);

    CGContextFillEllipseInRect(context, rect);
    CGContextRestoreGState(context);
}

- (void)setMaskRect:(CGRect)maskRect
{
    _maskRect = maskRect;
    [self setNeedsLayout];
}

- (void)maskAtDefault
{
    CGFloat width = self.bounds.size.width / 2;
    CGFloat height = self.bounds.size.height / 2;
    if (width >= height) {
        width = height;
    } else {
        height = width;
    }
    _maskRect = CGRectMake( (self.bounds.size.width - width) / 2, (self.bounds.size.height - height) / 2, width, height);
}

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
        CGPoint firstLocation = [first locationInView:self];
        CGPoint secondLocation = [second locationInView:self];
        initialDistance = distanceBetweenPoints(firstLocation, secondLocation);
    }
    if (!_isTached) {
        _isTached = !_isTached;
        [self setNeedsDisplay];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    NSUInteger count = [_touchArray count];

    if (count > 1) {
        UITouch *first = [_touchArray objectAtIndex:0];
        UITouch *second = [_touchArray objectAtIndex:1];
        CGPoint firstLocation = [first locationInView:self];
        CGPoint secondLocation = [second locationInView:self];
        CGFloat currentDistance = distanceBetweenPoints(firstLocation, secondLocation);

        if ( CGRectContainsPoint(self.maskRect, firstLocation) ) {

            if (initialDistance > 0) {
                double scale = currentDistance / initialDistance;
                CGRect r = self.maskRect;
                float deltaX = r.size.width * (scale - 1);
                float deltaY = r.size.height * (scale - 1);
                r.origin.x -= deltaX / 2;
                r.origin.y -= deltaY / 2;
                r.size.width = r.size.width * scale;
                r.size.height = r.size.height * scale;
                self.maskRect = r;
                NSLog(@"rrrrrrrrrrrrrr >>>>>>>>>>>>>>>>>>> %@", NSStringFromCGRect(r));
                [self setNeedsDisplay];
            }
        }

        initialDistance = currentDistance;
    } else if (count == 1) {
        UITouch *touch = [_touchArray objectAtIndex:0];
        CGPoint loc = [touch locationInView:self];
        CGPoint prevloc = [touch previousLocationInView:self];
        CGRect f = self.maskRect;
        float deltaX = loc.x - prevloc.x;
        float deltaY = loc.y - prevloc.y;
        f.origin.x += deltaX;
        f.origin.y += deltaY;
        self.maskRect = f;
        [self setNeedsDisplay];
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
    if ([_touchArray count] < 1) {
        _isTached = NO;
        [self setNeedsDisplay];
        if ([self.delegate respondsToSelector:@selector(maskViewDidFinishAdjustingArea:)]) {
            [self.delegate maskViewDidFinishAdjustingArea:self];
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
    if ([_touchArray count] < 1) {
        _isTached = NO;
        [self setNeedsDisplay];
    }
    initialDistance = 0;
}

@end
