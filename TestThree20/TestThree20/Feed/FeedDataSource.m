//
//  FeedDataSource.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedDataSource.h"

#import "FeedObject.h"

// Three20 Additions
#import <Three20Core/NSDateAdditions.h>

@implementation FeedDataSource

- (id)initWithSearchQuery:(NSString*)searchQuery
{
    if (self = [super init]) {
        feedModel_ = [[FeedModel alloc] initWithSearchQuery:searchQuery];
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(feedModel_);
    [super dealloc];
}

- (id<TTModel>)model {
    return feedModel_;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    NSMutableArray* items = [[NSMutableArray alloc] init];

    for (FeedObject* tweet in feedModel_.tweets) {
        //TTDPRINT(@"Response text: %@", response.text);
        TTStyledText* styledText = [TTStyledText textFromXHTML:
                                    [NSString stringWithFormat:@"%@\n<b>%@</b>",
                                     [[tweet.text stringByReplacingOccurrencesOfString:@"&"
                                                                            withString:@"&amp;"]
                                      stringByReplacingOccurrencesOfString:@"<"
                                      withString:@"&lt;"],
                                     [tweet.created formatRelativeTime]]
                                                    lineBreaks:YES URLs:YES];
        // If this asserts, it's likely that the tweet.text contains an HTML character that caused
        // the XML parser to fail.
        TTDASSERT(nil != styledText);
        [items addObject:[TTTableStyledTextItem itemWithText:styledText]];
    }

    if (!feedModel_.finished) {
        [items addObject:[TTTableMoreButton itemWithText:@"more…"]];
    }

    self.items = items;
    TT_RELEASE_SAFELY(items);
}

@end
