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
- (void)cancel;
@end

@implementation ThumbView

@synthesize thumbImageView = _thumbImageView;
@synthesize connection = _connection;
@synthesize data = _data;

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
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self cancel];
    [self setupImageView];
    self.thumbImageView.image = [UIImage imageWithData:self.data];
//    [self.thumbImageView setNeedsLayout];
//    [self setNeedsLayout];
    self.data = nil;
}

@end
