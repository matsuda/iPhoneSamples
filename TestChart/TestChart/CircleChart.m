//
//  CircleChart.m
//  TestChart
//
//  Created by Kosuke Matsuda on 2012/11/01.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "CircleChart.h"

static inline float radians(double degrees) { return degrees * M_PI / 180.0; }

@implementation CircleChart

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
    NSArray *colors = @[ [UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor] ];
    float points[] = {50.f, 20.f, 15.f, 10.f, 5.f};
    // float points[] = {5.f, 10.f, 15.f, 20.f, 50.f};
    const int count = sizeof(points) / sizeof(points[0]);

    float totalPoints = 0.f;
    for (int i = 0; i < count; i++) {
        totalPoints += points[i];
    }

    // 中心点の座標
    CGFloat x = CGRectGetMidX(rect);
    CGFloat y = CGRectGetMidY(rect);
    float margin = 5.f;

    // 半径
    CGFloat radius = CGRectGetWidth(rect) / 2 - margin;

    // 開始位置角度
    float startPoint = -90.0;
    // 終了位置角度
    float endPoint = 0;
    // 描画角度
    float delta = 0;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 255, 255, 255, 1.0);
    CGContextFillRect(context, rect);

    for (int i = 0; i < count; i++) {
        delta = ( points[i] * 360.f / totalPoints );
        endPoint = startPoint + delta;
		CGContextSetFillColor(context, CGColorGetComponents([[colors objectAtIndex:i] CGColor]));
        CGContextMoveToPoint(context, x, y);
        CGContextAddArc(context, x, y, radius, radians(startPoint), radians(endPoint), 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
        startPoint = endPoint;
    }
}

/****************************
 上記の逆（小さい値）から描画
 ****************************/
//- (void)drawRect:(CGRect)rect
//{
//    NSArray *colors = @[ [UIColor blueColor], [UIColor greenColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor redColor] ];
//    float points[] = {5.f, 10.f, 15.f, 20.f, 50.f};
//    const int count = sizeof(points) / sizeof(points[0]);
//
//    float totalPoints = 0.f;
//    for (int i = 0; i < count; i++) {
//        totalPoints += points[i];
//    }
//
//    // 中心点の座標
//    CGFloat x = CGRectGetMidX(rect);
//    CGFloat y = CGRectGetMidY(rect);
//
//    // 半径
//    CGFloat radius = CGRectGetWidth(rect) / 2;
//
//    // 開始位置角度
//    float startPoint = -90.0;
//    // 終了位置角度
//    float endPoint = 0;
//    // 描画角度
//    float delta = 0;
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    for (int i = 0; i < count; i++) {
//        delta = ( points[i] * 360.f / totalPoints );
//        endPoint = startPoint - delta;
//		CGContextSetFillColor(context, CGColorGetComponents([[colors objectAtIndex:i] CGColor]));
//        CGContextMoveToPoint(context, x, y);
//        CGContextAddArc(context, x, y, radius, radians(startPoint), radians(endPoint), 1);
//        CGContextClosePath(context);
//        CGContextFillPath(context);
//        startPoint = endPoint;
//    }
//}

/****************************
 test
 ****************************/
//- (void)drawRect:(CGRect)rect
//{
//    CGFloat x = 50.f;
//    CGFloat y = 140.f;
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    // CGContextBeginPath(context);
//    CGContextSetFillColor(context, CGColorGetComponents([[UIColor redColor] CGColor]));
//    CGContextMoveToPoint(context, x, y);
//    CGContextAddArc(context, x, y, 100, radians(0), radians(60), 0);
//    CGContextClosePath(context);
//    CGContextFillPath(context);
//
//    CGContextSetFillColor(context, CGColorGetComponents([[UIColor orangeColor] CGColor]));
//    CGContextMoveToPoint(context, x, y);
//    CGContextAddArc(context, x, y, 100, radians(0 + 60), radians(60 + 30), 0);
//    CGContextClosePath(context);
//    CGContextFillPath(context);
//
//    CGContextSetFillColor(context, CGColorGetComponents([[UIColor yellowColor] CGColor]));
//    CGContextMoveToPoint(context, x, y);
//    CGContextAddArc(context, x, y, 100, radians(0 + 60 + 30), radians(60 + 30 + 30), 0);
//    CGContextClosePath(context);
//    CGContextFillPath(context);
//
//    CGContextSetFillColor(context, CGColorGetComponents([[UIColor greenColor] CGColor]));
//    CGContextMoveToPoint(context, x, y);
//    CGContextAddArc(context, x, y, 100, radians(0 + 60 + 30 + 30), radians(60 + 30 + 30 + 10), 0);
//    CGContextClosePath(context);
//    CGContextFillPath(context);
//}

@end
