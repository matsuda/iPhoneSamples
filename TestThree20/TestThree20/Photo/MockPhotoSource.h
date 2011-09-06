//
//  MockPhotoSource.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MockPhotoSourceNormal = 0,
    MockPhotoSourceDelayed = 1,
    MockPhotoSourceVariableCount = 2,
    MockPhotoSourceLoadError = 4,
} MockPhotoSourceType;

@interface MockPhotoSource : TTURLRequestModel <TTPhotoSource> {
    MockPhotoSourceType type_;
    NSString* title_;
    NSMutableArray* photos_;
    NSArray* tempPhotos_;
    NSTimer* fakeLoadTimer_;
}

- (id)initWithType:(MockPhotoSourceType)type title:(NSString*)title photos:(NSArray*)photos photos2:(NSArray*)photos2;

@end
