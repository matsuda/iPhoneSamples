//
//  FeedObject.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FeedObject : NSObject {
    NSDate*   created_;
    NSNumber* tweetId_;
    NSString* text_;
    NSString* source_;
}

@property (nonatomic, retain) NSDate*   created;
@property (nonatomic, retain) NSNumber* tweetId;
@property (nonatomic, copy)   NSString* text;
@property (nonatomic, copy)   NSString* source;

@end
