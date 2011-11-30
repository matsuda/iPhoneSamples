//
//  ThumbsTableViewCell.m
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ThumbsTableViewCell.h"

static const CGFloat kSpacing = 4.0f;
static const CGFloat kDefaultThumbSize = 75.0f;


@interface ThumbsTableViewCell ()
@property (nonatomic, retain) NSMutableArray *thumbViews;
- (void)layoutThumbViews;
- (void)assignThumb:(int)thumbIndex toView:(UIImageView *)thumbView;
@end


@implementation ThumbsTableViewCell

@synthesize thumbs = _thumbs;
@synthesize thumbViews = _thumbViews;
@synthesize thumbSize = _thumbSize;
@synthesize thumbOrigin = _thumbOrigin;
@synthesize columnCount = _columnCount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.thumbViews = [[[NSMutableArray alloc] init] autorelease];
        _thumbSize = kDefaultThumbSize;
        _thumbOrigin = CGPointMake(kSpacing, 0);

        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)dealloc
{
    [_thumbs release], _thumbs = nil;
    [_thumbViews release], _thumbViews = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutThumbViews];
}

- (void)layoutThumbViews
{
    CGRect thumbFrame = CGRectMake(self.thumbOrigin.x, self.thumbOrigin.y, self.thumbSize, self.thumbSize);
    for (UIView *thumbView in self.thumbViews) {
        thumbView.frame = thumbFrame;
        thumbFrame.origin.x += kSpacing + self.thumbSize;
    }
}

- (void)setThumbs:(NSArray *)thumbs
{
    if (_thumbs == thumbs) {
        return;
    }
    [_thumbs release], _thumbs = nil;
    _thumbs = [thumbs retain];

    NSInteger columnCount = [thumbs count];
    for (UIImageView *thumbView in self.thumbViews) {
        [thumbView removeFromSuperview];
    }
    [self.thumbViews removeAllObjects];
    _columnCount = columnCount;
    for (NSInteger i = self.thumbViews.count; i < columnCount; ++i) {
        UIImageView *thumbView = [[[UIImageView alloc] init] autorelease];
        thumbView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:thumbView];
        [self.thumbViews addObject:thumbView];
        [self assignThumb:i toView:thumbView];
    }
}

- (void)assignThumb:(int)thumbIndex toView:(UIImageView *)thumbView
{
    UIImage *thumb = [self.thumbs objectAtIndex:thumbIndex];
    if (thumb) {
        thumbView.image = thumb;
        thumbView.hidden = NO;
    } else {
        thumbView.image = nil;
        thumbView.hidden = YES;
    }
}

@end
