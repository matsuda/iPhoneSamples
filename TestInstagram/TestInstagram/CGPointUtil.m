//
//  CGPointUtil.m
//  TestPinch
//
//  Created by matsuda on 12/07/20.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "CGPointUtil.h"

CGFloat RadiansToDegrees(CGFloat radians)
{
    return radians * 180 / M_PI;
}

CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}

CGFloat distanceBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
}

CGFloat angleBetweenPoints(CGPoint first, CGPoint second) {
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    CGFloat rads = atan(height/width);
    return RadiansToDegrees(rads);
    //degs = degrees(atan((top - bottom)/(right - left)))
}
