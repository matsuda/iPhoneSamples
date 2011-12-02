//
//  ThumbView.m
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ThumbView.h"

@interface ThumbView ()
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;
- (void)cancel;
- (void)toggleIndicator:(BOOL)show;
@end

@implementation ThumbView

@synthesize thumbImageView = _thumbImageView;
@synthesize connection = _connection;
@synthesize data = _data;
@synthesize indicator = _indicator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    [self cancel];
    [_thumbImageView release], _thumbImageView = nil;
    [_data release], _data = nil;
    [_indicator release], _indicator = nil;

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

- (void)cancel
{
    if (_connection) {
        [_connection cancel];
        [_connection release], _connection = nil;
    }
}

- (void)toggleIndicator:(BOOL)show
{
    if (!self.indicator) {
        self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite] autorelease];
        [self addSubview:self.indicator];
    }
    if (show) {
        [self.indicator startAnimating];
        self.indicator.hidden = NO;
        [self setNeedsLayout];
    } else {
        [self.indicator stopAnimating];
        self.indicator.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.indicator) {
        CGRect f = self.indicator.frame;
        CGPoint p = CGPointMake((self.frame.size.width - self.indicator.frame.size.width) / 2, (self.frame.size.height - self.indicator.frame.size.height) / 2);
        f.origin = p;
        self.indicator.frame = f;
    }
}

- (void)setupImageView
{
    if (!_thumbImageView) {
        self.thumbImageView = [[[UIImageView alloc] init] autorelease];
        self.thumbImageView.frame = self.bounds;
        self.thumbImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.thumbImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.thumbImageView];
    }
}

- (void)loadImage:(NSString *)url
{
    [self cancel];
    [self toggleIndicator:YES];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    self.connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self cancel];
    [self toggleIndicator:NO];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self cancel];
    [self setupImageView];
    self.thumbImageView.image = [UIImage imageWithData:self.data];
//    [self.thumbImageView setNeedsLayout];
//    [self setNeedsLayout];
    self.data = nil;
    [self toggleIndicator:NO];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.5f;
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 1.0f;
    [super touchesEnded:touches withEvent:event];
}

@end
