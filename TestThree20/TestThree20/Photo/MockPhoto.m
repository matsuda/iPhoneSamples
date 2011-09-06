//
//  MockPhoto.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MockPhoto.h"


@implementation MockPhoto

@synthesize photoSource = photoSource_, size = size_, index = index_, caption = caption_;

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size {
    return [self initWithURL:URL smallURL:smallURL size:size caption:nil];
}

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size
          caption:(NSString*)caption {
    if (self = [super init]) {
        photoSource_ = nil;
        URL_ = [URL copy];
        smallURL_ = [smallURL copy];
        thumbURL_ = [smallURL copy];
        size_ = size;
        caption_ = [caption copy];
        index_ = NSIntegerMax;
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(URL_);
    TT_RELEASE_SAFELY(smallURL_);
    TT_RELEASE_SAFELY(thumbURL_);
    TT_RELEASE_SAFELY(caption_);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTPhoto

- (NSString*)URLForVersion:(TTPhotoVersion)version {
    if (version == TTPhotoVersionLarge) {
        return URL_;
    } else if (version == TTPhotoVersionMedium) {
        return URL_;
    } else if (version == TTPhotoVersionSmall) {
        return smallURL_;
    } else if (version == TTPhotoVersionThumbnail) {
        return thumbURL_;
    } else {
        return nil;
    }
}

@end
