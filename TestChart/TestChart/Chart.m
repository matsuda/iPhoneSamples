//
//  Chart.m
//  TestChart
//
//  Created by Kosuke Matsuda on 2012/11/02.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "Chart.h"
#import "GlyphTable.m"

// 文字列を Glyphs 変換します
static void string2griph(NSString *str, NSString *fontName, CGGlyph *_glyphs, size_t *griphLen) {
    CGFontRef font  = CGFontCreateWithFontName((__bridge CFStringRef)fontName);
    fontTable *tbl  = readFontTableFromCGFont(font);
    int originalLen = [str length];
    unichar _chars[[str length]];
    int i;
    for(i = 0; i < [str length]; i++) {
        _chars[i] = [str characterAtIndex:i];
    }
    mapCharactersToGlyphsInFont(tbl, _chars, originalLen, _glyphs, griphLen);
    freeFontTable(tbl);
    CGFontRelease(font);
}

@interface Chart ()
@property (assign, nonatomic) NSInteger numberX;
@property (assign, nonatomic) NSInteger numberY;
@end

@implementation Chart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _numberX = 0;
        _numberY = 0;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.numberX = [self.dataSource numberOfXAxisInChart:self];
    self.numberY = [self.dataSource numberOfYAxisInChart:self];
    if (self.numberX == 0 || self.numberY == 0) return;

    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawRectBackground:rect context:context];
    float margin = 5.f;
    CGRect fRect = CGRectMake(margin, margin, CGRectGetWidth(rect) - margin * 2, CGRectGetHeight(rect) - margin * 2);
 
    // 枠
    [self drawRectFrame:fRect context:context];
    // X軸
    [self drawRectXAxis:fRect context:context number:self.numberX];
    // Y軸
    [self drawRectYAxis:fRect context:context number:self.numberY];

    [self drawRectCell:fRect context:context];
}

- (void)drawRectCell:(CGRect)rect context:(CGContextRef)context
{
    CGFloat pointX = CGRectGetMinX(rect);
    CGFloat pointY = CGRectGetMinY(rect);
    CGFloat rangeX = [self rangeXAtRect:rect number:self.numberX];
    CGFloat rangeY = [self rangeYAtRect:rect number:self.numberY];

    // drawAtPoint用
    NSString *fontName = @"HiraKakuProN-W6";
    UIFont *font = [UIFont fontWithName:fontName size:20.f];

    CGAffineTransform transform = CGAffineTransformMakeRotation(0);
    transform = CGAffineTransformScale(transform, 1.0, -1.0);
    // CGAffineTransform transform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);

    CGContextSetTextMatrix(context, transform);
    CGContextSelectFont(context, [fontName UTF8String], 20.f, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFillStroke);
    CGContextSetRGBFillColor(context, 0, 0.6, 0.4, 1.0);

    for (int i = 0; i < self.numberX; i++) {
        for (int j = 0; j < self.numberY; j++) {
            ChartCoordinate coordinate = {i, j};
            NSString *str = [self.dataSource chart:self cellAtCoordinate:coordinate];
            CGSize size = [str sizeWithFont:font forWidth:rangeX lineBreakMode:NSLineBreakByWordWrapping];
            CGFloat x = pointX + rangeX * i + (rangeX - size.width) / 2;
            CGFloat y = pointY + rangeY * j + size.height;

            // 日本語を含んでいる場合
            CGGlyph _glyphs[[str length]];
            size_t griphLen = 0;
            string2griph(str, @"HiraKakuProN-W6", _glyphs, &griphLen);
            CGContextShowGlyphsAtPoint(context, x, y, _glyphs, griphLen);

            // 日本語を全く含んでない場合
            // CGContextShowTextAtPoint(context, x, y, [str UTF8String], [str length]);

            // 日本語を含んでいる場合
            // [str drawAtPoint:CGPointMake(x, y) withFont:font];
        }
    }
}

- (void)drawRectXAxis:(CGRect)rect context:(CGContextRef)context number:(NSInteger)number
{
    CGFloat range = CGRectGetWidth(rect) / number;
    CGFloat x = CGRectGetMinX(rect);
    CGFloat y = CGRectGetMinY(rect);

    CGContextSetRGBStrokeColor(context, 0.66, 0.66, 0.66, 1.0);
    CGContextSetLineWidth(context, 0.5f);

    for (int i = 1; i < number; i++) {
        x = x + range;
        y = CGRectGetMinY(rect);
        CGContextMoveToPoint(context, x, y);
        y = CGRectGetMaxY(rect);
        CGContextAddLineToPoint(context, x, y);
        CGContextStrokePath(context);
    }
    CGContextFlush(context);
}

- (void)drawRectYAxis:(CGRect)rect context:(CGContextRef)context number:(NSInteger)number
{
    CGFloat range = CGRectGetHeight(rect) / number;
    CGFloat x = CGRectGetMinX(rect);
    CGFloat y = CGRectGetMinY(rect);

    CGContextSetRGBStrokeColor(context, 0.66, 0.66, 0.66, 1.0);
    CGContextSetLineWidth(context, 0.5f);

    for (int i = 1; i < number; i++) {
        x = CGRectGetMinX(rect);
        y = y + range;
        CGContextMoveToPoint(context, x, y);
        x = CGRectGetMaxX(rect);
        CGContextAddLineToPoint(context, x, y);
        CGContextStrokePath(context);
    }
    CGContextFlush(context);
}

- (void)drawRectFrame:(CGRect)rect context:(CGContextRef)context
{
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0);
    CGContextSetLineWidth(context, 0.8);
    CGContextStrokeRect(context, rect);
    CGContextFlush(context);
}

- (void)drawRectBackground:(CGRect)rect context:(CGContextRef)context
{
    CGContextSetFillColor(context, CGColorGetComponents([UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor));
    CGContextFillRect(context, rect);
}

- (CGFloat)rangeXAtRect:(CGRect)rect number:(NSInteger)number
{
    return CGRectGetWidth(rect) / number;
}

- (CGFloat)rangeYAtRect:(CGRect)rect number:(NSInteger)number
{
    return CGRectGetHeight(rect) / number;
}

@end
