//
//  KMCarouselView.m
//  TestCarousel
//
//  Created by Kosuke Matsuda on 11/12/05.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "KMCarouselView.h"

@interface KMCarouselView ()
- (void)setupScrollView:(CGRect)frame;
- (void)setupItems;
@end

@implementation KMCarouselView

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

@synthesize scrollView = _scrollView;
@synthesize items = _items;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if ([self pointInside:point withEvent:event]) {
//        return self.scrollView;
//    }
//    return nil;
//}

- (void)setupScrollView:(CGRect)frame
{
//    NSLog(@"%@", NSStringFromCGRect(self.bounds));
    self.scrollView = [[[UIScrollView alloc] initWithFrame:self.bounds] autorelease];
    self.scrollView = [[[UIScrollView alloc] initWithFrame:self.bounds] autorelease];
    self.scrollView.backgroundColor = [UIColor orangeColor];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
//    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.scrollsToTop = NO;

    self.scrollView.clearsContextBeforeDrawing     = NO;
//    self.scrollView.delaysContentTouches           = NO;

    [self addSubview:self.scrollView];
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
    CGPoint p = self.scrollView.frame.origin;
    CGSize contentSize = CGSizeZero;

    NSInteger itemCount = [self.dataSource numberOfItemsInCarouselView:self];

    for (NSInteger i = 0; i < itemCount; i++) {
        UIView *item = [self.dataSource carouselViewItemAtIndex:i];
        CGRect itemFrame = item.frame;
        itemFrame.origin = CGPointMake(p.x, p.y);
        item.frame = itemFrame;

//        UITapGestureRecognizer *recognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureItem:)] autorelease];
//        [self.scrollView addGestureRecognizer:recognizer];
//        recognizer.delegate = self;

        [self.scrollView addSubview:item];

        contentSize.width += item.frame.size.width;
        if (contentSize.height < item.frame.size.height) {
            contentSize.height = item.frame.size.height;
        }
        p.x += item.frame.size.width;
    }
    self.scrollView.contentSize = contentSize;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    // シングルタッチ
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    NSLog(@"x座標:%f y座標:%f", location.x, location.y);
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

- (void)handleTapGestureItem:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"handleTapGestureItem");
    NSLog(@"%@", recognizer.view);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSInteger index = self.scrollView.contentOffset.x / scrollView.bounds.size.width;
//    if ([self.delegate respondsToSelector:@selector(carouselView:didSelectItemAtIndex:)]) {
//        [self.delegate carouselView:self didSelectItemAtIndex:index];
//    }
}

@end
