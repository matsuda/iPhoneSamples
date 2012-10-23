//
//  CGPointUtil.h
//  TestPinch
//
//  Created by matsuda on 12/07/20.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

CGFloat RadiansToDegrees(CGFloat radians);
CGFloat DegreesToRadians(CGFloat degrees);

CGFloat distanceBetweenPoints(CGPoint first, CGPoint second);
CGFloat angleBetweenPoints(CGPoint first, CGPoint second);
