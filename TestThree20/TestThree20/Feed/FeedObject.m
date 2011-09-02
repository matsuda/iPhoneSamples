//
//  FeedObject.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedObject.h"


@implementation FeedObject

@synthesize created   = created_;
@synthesize tweetId   = tweetId_;
@synthesize text      = text_;
@synthesize source    = source_;

- (void) dealloc {
    TT_RELEASE_SAFELY(created_);
    TT_RELEASE_SAFELY(tweetId_);
    TT_RELEASE_SAFELY(text_);
    TT_RELEASE_SAFELY(source_);
    [super dealloc];
}

@end
