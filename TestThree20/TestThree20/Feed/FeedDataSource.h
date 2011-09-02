//
//  FeedDataSource.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FeedModel.h"

@interface FeedDataSource : TTListDataSource {
    FeedModel* feedModel_;
}

- (id)initWithSearchQuery:(NSString*)searchQuery;

@end
