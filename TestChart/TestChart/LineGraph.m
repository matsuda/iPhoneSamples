//
//  LineGraph.m
//  TestChart
//
//  Created by Kosuke Matsuda on 2012/11/01.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "LineGraph.h"

@implementation LineGraph

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    float margin = 4.f;
    int count = 100;

    float limit = CGRectGetWidth(rect) - margin * 2;
    CGPoint points[count];

    CGFloat x = 0.f;
    CGFloat y = 0.f;
    for (int i = 0; i < count; i++) {
        x = limit / count * i + margin;
        y = arc4random() % (int)limit + margin;
        points[i] = CGPointMake(x, y);
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1, 1, 1, 1.0);
    CGContextFillRect(context, rect);

    CGContextSaveGState(context);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1.0);
    CGContextSetLineWidth(context, 1.f);
    CGContextAddLines(context, points, count);
    CGContextStrokePath(context);
    CGContextFlush(context);
    CGContextRestoreGState(context);
}

@end
