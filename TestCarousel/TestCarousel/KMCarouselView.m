//
//  KMCarouselView.m
//  TestCarousel
//
//  Created by Kosuke Matsuda on 11/12/05.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "KMCarouselView.h"

static CGFloat kKMCarouselViewPadding = 5.0f;

typedef enum{
	KMCarouselViewScrollButtonPrev,
	KMCarouselViewScrollButtonNext
} KMCarouselViewScrollButton;

@interface KMCarouselView ()

@property (nonatomic, retain) UIButton *prevButton;
@property (nonatomic, retain) UIButton *nextButton;

@property (nonatomic, retain) NSTimer *timer;

- (void)setupScrollView:(CGRect)frame;
- (void)setupPrevItem;
- (void)setupNextItem;
- (void)toggleScrollItem;
- (void)setupItems;

@end


@implementation KMCarouselView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

@synthesize scrollView = _scrollView;
@synthesize items = _items;

@synthesize prevButton = _prevButton;
@synthesize nextButton = _nextButton;

@synthesize timer = _timer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        [self setupPrevItem];
        [self setupNextItem];
        [self setupScrollView:frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items
{
    self = [self initWithFrame:frame];
    if (self) {
        self.items = items;
    }
    return self;
}

- (void)dealloc
{
//    _dataSource = nil;
//    _delegate = nil;
    [_scrollView release], _scrollView = nil;
    [_items release], _items = nil;
    [_prevButton release], _prevButton = nil;
    [_nextButton release], _nextButton = nil;
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    [_timer release], _timer = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setupScrollView:(CGRect)frame
{
    CGRect f = self.bounds;
    f.size = CGSizeMake(frame.size.width, frame.size.height);
    f.origin.x = self.prevButton.frame.origin.x + self.prevButton.frame.size.width + kKMCarouselViewPadding;
    f.origin.y += kKMCarouselViewPadding;
    f.size.width -= (self.prevButton.frame.size.width + self.nextButton.frame.size.width + kKMCarouselViewPadding * 2);
    f.size.height -= kKMCarouselViewPadding * 2;

    self.scrollView = [[UIScrollView new] autorelease];
    self.scrollView.frame = f;
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;

//    self.scrollView.scrollEnabled = YES;
//    self.scrollView.clipsToBounds = NO;
//    self.scrollView.scrollsToTop = NO;
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.clearsContextBeforeDrawing     = NO;
//    self.scrollView.delaysContentTouches           = NO;

    [self addSubview:self.scrollView];
}

- (void)setupPrevItem
{
    UIImage *image = [UIImage imageNamed:@"pre-btn"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect f = CGRectZero;
    f.size = CGSizeMake(image.size.width, image.size.height);
    f.origin.y = (self.frame.size.height - image.size.height) / 2;
    button.frame = f;
    [button setImage:image forState:UIControlStateNormal];
    button.tag = KMCarouselViewScrollButtonPrev;

    [button addTarget:self action:@selector(didTouchDownToStartAutoScroll:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(didTouchDownToStopAutoScroll:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(didTouchDownToStopAutoScroll:) forControlEvents:UIControlEventTouchUpOutside];

    [self addSubview:button];
    self.prevButton = button;
}

- (void)setupNextItem
{
    UIImage *image = [UIImage imageNamed:@"next-btn"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect f = CGRectZero;
    f.size = CGSizeMake(image.size.width, image.size.height);
    f.origin.x = self.frame.size.width - f.size.width;
    f.origin.y = (self.frame.size.height - image.size.height) / 2;
    button.frame = f;
    [button setImage:image forState:UIControlStateNormal];
    button.tag = KMCarouselViewScrollButtonNext;

    [button addTarget:self action:@selector(didTouchDownToStartAutoScroll:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(didTouchDownToStopAutoScroll:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(didTouchDownToStopAutoScroll:) forControlEvents:UIControlEventTouchUpOutside];

    [self addSubview:button];
    self.nextButton = button;
}

- (void)didTouchDownToStartAutoScroll:(UIButton *)button
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    CGFloat interval = (button.tag == KMCarouselViewScrollButtonPrev) ? -3.f : 3.f;

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:interval], @"scrollInterval", nil];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(didFireAutoScroll:) userInfo:dict repeats:YES];
}

- (void)didTouchDownToStopAutoScroll:(UIButton *)button
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
}

- (void)setDataSource:(id<KMCarouselViewDataSource>)dataSource
{
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        [self setupItems];
    }
}

- (void)setupItems
{
    CGPoint p = self.scrollView.bounds.origin;
    CGSize contentSize = CGSizeZero;

    NSInteger itemCount = [self.dataSource numberOfItemsInCarouselView:self];

    for (NSInteger i = 0; i < itemCount; i++) {
        UIView *item = [self.dataSource carouselView:self viewAtIndex:i];
        CGRect itemFrame = item.frame;
        itemFrame.origin = CGPointMake(p.x, p.y);
        item.frame = itemFrame;

        [self.scrollView addSubview:item];

        contentSize.width += item.frame.size.width;
        if (contentSize.height < item.frame.size.height) {
            contentSize.height = item.frame.size.height;
        }
        p.x += item.frame.size.width;
    }
    self.scrollView.contentSize = contentSize;
}

- (void)didFireAutoScroll:(NSTimer *)timer
{
    NSDictionary *info = [timer userInfo];
    CGPoint scrollOffset = self.scrollView.contentOffset;
    scrollOffset.x += [[info objectForKey:@"scrollInterval"] floatValue];

    CGFloat minOffset = 0.f;
    CGFloat maxOffset = self.scrollView.contentSize.width - self.scrollView.frame.size.width;

    if (scrollOffset.x <= minOffset) {
        scrollOffset.x = minOffset;
    } else if (scrollOffset.x >= maxOffset) {
        scrollOffset.x = maxOffset;
    }
    self.scrollView.contentOffset = scrollOffset;
}

- (void)toggleScrollItem
{
    CGFloat offsetX = self.scrollView.contentOffset.x;
    CGFloat minOffset = 0.f;
    CGFloat maxOffset = self.scrollView.contentSize.width - self.scrollView.frame.size.width;

    if (minOffset > maxOffset) {
        self.prevButton.hidden = YES;
        self.nextButton.hidden = YES;
    } else if (minOffset >= offsetX) {
        self.prevButton.hidden = YES;
        self.nextButton.hidden = NO;
    } else if (minOffset < offsetX && maxOffset > offsetX) {
        self.prevButton.hidden = NO;
        self.nextButton.hidden = NO;
    } else if (maxOffset <= offsetX) {
        self.prevButton.hidden = NO;
        self.nextButton.hidden = YES;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self toggleScrollItem];
}

@end
