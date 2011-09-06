//
//  MockPhotoSource.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MockPhotoSource.h"


@implementation MockPhotoSource

@synthesize title = title_;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (void)fakeLoadReady {
    fakeLoadTimer_ = nil;
    
    if (type_ & MockPhotoSourceLoadError) {
        [_delegates perform: @selector(model:didFailLoadWithError:)
                 withObject: self
                 withObject: nil];
    } else {
        NSMutableArray* newPhotos = [NSMutableArray array];
        
        for (int i = 0; i < photos_.count; ++i) {
            id<TTPhoto> photo = [photos_ objectAtIndex:i];
            if ((NSNull*)photo != [NSNull null]) {
                [newPhotos addObject:photo];
            }
        }
        
        [newPhotos addObjectsFromArray:tempPhotos_];
        TT_RELEASE_SAFELY(tempPhotos_);
        
        [photos_ release];
        photos_ = [newPhotos retain];
        
        for (int i = 0; i < photos_.count; ++i) {
            id<TTPhoto> photo = [photos_ objectAtIndex:i];
            if ((NSNull*)photo != [NSNull null]) {
                photo.photoSource = self;
                photo.index = i;
            }
        }
        
        [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithType:(MockPhotoSourceType)type title:(NSString*)title photos:(NSArray*)photos photos2:(NSArray*)photos2 {
    if (self = [super init]) {
        type_ = type;
        title_ = [title copy];
        photos_ = photos2 ? [photos mutableCopy] : [[NSMutableArray alloc] init];
        tempPhotos_ = photos2 ? [photos2 retain] : [photos retain];
        fakeLoadTimer_ = nil;
        
        for (int i = 0; i < photos_.count; ++i) {
            id<TTPhoto> photo = [photos_ objectAtIndex:i];
            if ((NSNull*)photo != [NSNull null]) {
                photo.photoSource = self;
                photo.index = i;
            }
        }
        
        if (!(type_ & MockPhotoSourceDelayed || photos2)) {
            [self performSelector:@selector(fakeLoadReady)];
        }
    }
    return self;
}

- (id)init {
    return [self initWithType:MockPhotoSourceNormal title:nil photos:nil photos2:nil];
}

- (void)dealloc {
    [fakeLoadTimer_ invalidate];
    TT_RELEASE_SAFELY(photos_);
    TT_RELEASE_SAFELY(tempPhotos_);
    TT_RELEASE_SAFELY(title_);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTModel

- (BOOL)isLoading {
    return !!fakeLoadTimer_;
}

- (BOOL)isLoaded {
    return !!photos_;
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (cachePolicy & TTURLRequestCachePolicyNetwork) {
        [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
        
        TT_RELEASE_SAFELY(photos_);
        fakeLoadTimer_ = [NSTimer scheduledTimerWithTimeInterval:2 target:self
                                                        selector:@selector(fakeLoadReady) userInfo:nil repeats:NO];
    }
}

- (void)cancel {
    [fakeLoadTimer_ invalidate];
    fakeLoadTimer_ = nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTPhotoSource

- (NSInteger)numberOfPhotos {
    if (tempPhotos_) {
        return photos_.count + (type_ & MockPhotoSourceVariableCount ? 0 : tempPhotos_.count);
    } else {
        return photos_.count;
    }
}

- (NSInteger)maxPhotoIndex {
    return photos_.count-1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)photoIndex {
    if (photoIndex < photos_.count) {
        id photo = [photos_ objectAtIndex:photoIndex];
        if (photo == [NSNull null]) {
            return nil;
        } else {
            return photo;
        }
    } else {
        return nil;
    }
}

@end
