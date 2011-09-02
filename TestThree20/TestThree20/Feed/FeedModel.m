//
//  FeedModel.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SBJson.h"

#import "FeedModel.h"

#import "FeedObject.h"

// Twitter search API documented here:
// http://apiwiki.twitter.com/w/page/22554756/Twitter-Search-API-Method:-search
static NSString* kTwitterSearchFeedFormat = @"http://search.twitter.com/search.json?q=%@&rpp=%u&page=%u";

@implementation FeedModel

@synthesize searchQuery     = searchQuery_;
@synthesize tweets          = tweets_;
@synthesize resultsPerPage  = resultsPerPage_;
@synthesize finished        = finished_;

- (id)initWithSearchQuery:(NSString*)searchQuery {
    if (self = [super init]) {
        self.searchQuery = searchQuery;
        resultsPerPage_ = 10;
        page_ = 1;
        tweets_ = [[NSMutableArray array] retain];
    }
    return self;
}

- (void) dealloc {
    TT_RELEASE_SAFELY(searchQuery_);
    TT_RELEASE_SAFELY(tweets_);
    [super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (!self.isLoading && TTIsStringWithAnyText(searchQuery_)) {
        if (more) {
            page_++;
        }
        else {
            page_ = 1;
            finished_ = NO;
            [tweets_ removeAllObjects];
        }

        NSString* url = [NSString stringWithFormat:kTwitterSearchFeedFormat, searchQuery_, resultsPerPage_, page_];

        TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];

        request.cachePolicy = cachePolicy;
        request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;

        // TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
        TTURLDataResponse* response = [[TTURLDataResponse alloc] init];
        request.response = response;
        TT_RELEASE_SAFELY(response);

        [request send];
    }
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
    // TTURLJSONResponse* response = request.response;
    TTURLDataResponse* response = request.response;
    NSString *json = [[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding];
    NSDictionary *rootObject = [json JSONValue];
    [json release];
    TTDASSERT([rootObject isKindOfClass:[NSDictionary class]]);

    NSDictionary* feed = rootObject;
    TTDASSERT([[feed objectForKey:@"results"] isKindOfClass:[NSArray class]]);

    NSArray* entries = [feed objectForKey:@"results"];

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"EEE, dd MMMM yyyy HH:mm:ss ZZ"];

    NSMutableArray* tweets = [NSMutableArray arrayWithCapacity:[entries count]];

    for (NSDictionary* entry in entries) {
        FeedObject* tweet = [[FeedObject alloc] init];

        NSDate* date = [dateFormatter dateFromString:[entry objectForKey:@"created_at"]];
        tweet.created = date;
        tweet.tweetId = [NSNumber numberWithLongLong:[[entry objectForKey:@"id"] longLongValue]];
        tweet.text = [entry objectForKey:@"text"];
        tweet.source = [entry objectForKey:@"source"];

        [tweets addObject:tweet];
        TT_RELEASE_SAFELY(tweet);
    }
    finished_ = tweets.count < resultsPerPage_;
    [tweets_ addObjectsFromArray:tweets];

    TT_RELEASE_SAFELY(dateFormatter);

    [super requestDidFinishLoad:request];
}

@end
