//
//  ThumbsTableViewCell.m
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ThumbsTableViewCell.h"
#import "ThumbView.h"

static const CGFloat kDefaultThumbSize = 100.0f;


@interface ThumbsTableViewCell ()
@property (nonatomic, retain) NSMutableArray *thumbViews;
@property (nonatomic) CGFloat thumbSize;
@property (nonatomic) CGPoint thumbOrigin;
@property (nonatomic) NSInteger columnCount;
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
        self.thumbSize = kDefaultThumbSize;
        self.thumbOrigin = CGPointMake(kThumbSpacing, 0);

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

- (void)setThumbs:(NSArray *)thumbs
{
    if (_thumbs == thumbs) {
        return;
    }
    [_thumbs release], _thumbs = nil;
    _thumbs = [thumbs retain];

    NSInteger columnCount = [thumbs count];
    for (UIView *thumbView in self.thumbViews) {
        [thumbView removeFromSuperview];
    }
    [self.thumbViews removeAllObjects];
    _columnCount = columnCount;

    CGRect thumbFrame = CGRectMake(self.thumbOrigin.x, self.thumbOrigin.y, self.thumbSize, self.thumbSize);
    for (NSInteger i = self.thumbViews.count; i < columnCount; ++i) {
        ThumbView *thumbView = [[[ThumbView alloc] initWithFrame:thumbFrame] autorelease];
        thumbView.backgroundColor = [UIColor grayColor];
        [thumbView loadImage:@"http://matsuda.me/images/logo.png"];

        [self.contentView addSubview:thumbView];
        [self.thumbViews addObject:thumbView];
        thumbFrame.origin.x += kThumbSpacing + self.thumbSize;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // マルチタッチ
    // for (UITouch *touch in touches) {
    //     CGPoint location = [touch locationInView:self];
    //     NSLog(@"x座標:%f y座標:%f",location.x,location.y);
    // }

    // シングルタッチ
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    NSLog(@"x座標:%f y座標:%f",location.x,location.y);
    NSInteger thumbIndex = location.x / (kThumbSize + kThumbSpacing);
    if (thumbIndex >= [self.thumbs count]) thumbIndex -= 1;
    NSLog(@"thumbIndex : %d", thumbIndex);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
