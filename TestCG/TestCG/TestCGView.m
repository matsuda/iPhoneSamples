//
//  TestCGView.m
//  TestCG
//
//  Created by matsuda on 12/06/14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestCGView.h"

@implementation TestCGView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(c, 0.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(c, 1.f);

    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat pointerSize = 20;
    CGFloat cornerRadius = 20;
    CGFloat margin = 5;

    CGRect baseRect = CGRectMake(rect.origin.x + margin, rect.origin.y + margin, CGRectGetWidth(rect) - margin * 2, CGRectGetHeight(rect) - margin * 2);
    CGPoint topLeft = CGPointMake(baseRect.origin.x, baseRect.origin.y);
    CGPoint buttomLeft = CGPointMake(baseRect.origin.x, CGRectGetMaxY(baseRect) - pointerSize);
    CGPoint topRight = CGPointMake(CGRectGetMaxX(baseRect), baseRect.origin.y);
    CGPoint buttomRight = CGPointMake(CGRectGetMaxX(baseRect), CGRectGetMaxY(baseRect) - pointerSize);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(baseRect), CGRectGetMaxY(baseRect));

    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, NULL, startPoint.x - pointerSize, startPoint.y - pointerSize);

    CGPathAddArcToPoint(path, NULL, buttomLeft.x, buttomLeft.y, buttomLeft.x, buttomLeft.y - cornerRadius, cornerRadius);
    CGPathAddArcToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + cornerRadius, topLeft.y, cornerRadius);
    CGPathAddArcToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + cornerRadius, cornerRadius);
    CGPathAddArcToPoint(path, NULL, buttomRight.x, buttomRight.y, buttomRight.x - cornerRadius, buttomRight.y, cornerRadius);

    CGPathAddLineToPoint(path, NULL, startPoint.x + cornerRadius, startPoint.y - cornerRadius);
    CGPathCloseSubpath(path);

    CGContextAddPath(c, path);
    CGContextSaveGState(c);
    CGContextSetShadow(c, CGSizeMake(0, 3), 5);
    CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
//    CGContextStrokePath(c);
    CGContextFillPath(c);
    CGContextRestoreGState(c);

    CGPathRelease(path);
}

@end
