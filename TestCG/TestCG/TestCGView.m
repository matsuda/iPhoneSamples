//
//  TestCGView.m
//  TestCG
//
//  Created by matsuda on 12/06/14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*
 https://github.com/chrismiles/CMPopTipView
 */
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
    CGPoint basePoint = CGPointMake(CGRectGetMidX(baseRect), CGRectGetMaxY(baseRect));

    CGPathMoveToPoint(path, NULL, basePoint.x, basePoint.y);
    CGPathAddLineToPoint(path, NULL, basePoint.x - pointerSize, basePoint.y - pointerSize);

    CGPathAddArcToPoint(path, NULL, buttomLeft.x, buttomLeft.y, buttomLeft.x, buttomLeft.y - cornerRadius, cornerRadius);
    CGPathAddArcToPoint(path, NULL, topLeft.x, topLeft.y, topLeft.x + cornerRadius, topLeft.y, cornerRadius);
    CGPathAddArcToPoint(path, NULL, topRight.x, topRight.y, topRight.x, topRight.y + cornerRadius, cornerRadius);
    CGPathAddArcToPoint(path, NULL, buttomRight.x, buttomRight.y, buttomRight.x - cornerRadius, buttomRight.y, cornerRadius);

    CGPathAddLineToPoint(path, NULL, basePoint.x + cornerRadius, basePoint.y - cornerRadius);
    CGPathCloseSubpath(path);

    /*
     shadow
     */
    CGContextAddPath(c, path);
    CGContextSaveGState(c);
    CGContextSetShadow(c, CGSizeMake(0, 3), 5);
    CGContextSetRGBFillColor(c, 0.0, 0.0, 0.0, 0.9);
//    CGContextStrokePath(c);
    CGContextFillPath(c);
    CGContextRestoreGState(c);

    /*
     background
     */
    CGContextAddPath(c, path);
    CGContextClip(c);
    CGFloat middlePointY = CGRectGetMidY(rect) / self.bounds.size.height;

    UIColor *backgroundColor = [UIColor colorWithRed:220.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
//    UIColor *backgroundColor = [UIColor colorWithRed:62.0/255.0 green:60.0/255.0 blue:154.0/255.0 alpha:1.0];

    CGFloat red, green, blue, alpha;
    int numComponents = CGColorGetNumberOfComponents([backgroundColor CGColor]);
    const CGFloat *components = CGColorGetComponents([backgroundColor CGColor]);
    if (numComponents == 2) {
        red = components[0];
        green = components[0];
        blue = components[0];
        alpha = components[1];
    } else {
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    CGFloat colorList[] = {
        red * 1.16, green * 1.16, blue * 1.16, alpha,
        red * 1.16, green * 1.16, blue * 1.16, alpha,
        red * 1.08, green * 1.08, blue * 1.08, alpha,
        red, green, blue, alpha,
        red, green, blue, alpha,
    };

    size_t locationCount = 5;
    CGFloat locationList[] = {0.0, middlePointY - 0.03, middlePointY, middlePointY + 0.03, 1.0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorList, locationList, locationCount);
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0, CGRectGetMaxY(self.bounds));

    CGContextDrawLinearGradient(c, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

    /*
     border
     */
    UIColor *borderColor = [UIColor blackColor];
    int numBorderComponents = CGColorGetNumberOfComponents([borderColor CGColor]);
    const CGFloat *borderComponents = CGColorGetComponents([borderColor CGColor]);
    CGFloat r, g, b, a;
    if (numBorderComponents == 2) {
        r = borderComponents[0];
        g = borderComponents[0];
        b = borderComponents[0];
        a = borderComponents[1];
    } else {
        r = borderComponents[0];
        g = borderComponents[1];
        b = borderComponents[2];
        a = borderComponents[3];
    }

    CGContextSetRGBStrokeColor(c, r, g, b, a);
    CGContextAddPath(c, path);
    CGContextDrawPath(c, kCGPathStroke);

    CGPathRelease(path);
}

@end
