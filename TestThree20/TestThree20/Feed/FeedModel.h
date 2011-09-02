//
//  FeedModel.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FeedModel : TTURLRequestModel {
    NSString* searchQuery_;

    NSMutableArray*  tweets_;

    NSUInteger page_;             // page of search request
    NSUInteger resultsPerPage_;   // results per page, once the initial query is made
    // this value shouldn't be changed
    BOOL finished_;
}

@property (nonatomic, copy)     NSString*       searchQuery;
@property (nonatomic, readonly) NSMutableArray* tweets;
@property (nonatomic, assign)   NSUInteger      resultsPerPage;
@property (nonatomic, readonly) BOOL            finished;

- (id)initWithSearchQuery:(NSString*)searchQuery;

@end
