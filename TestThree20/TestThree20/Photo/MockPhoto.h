//
//  MockPhoto.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MockPhoto : NSObject <TTPhoto> {
    id<TTPhotoSource> photoSource_;
    NSString* thumbURL_;
    NSString* smallURL_;
    NSString* URL_;
    CGSize size_;
    NSInteger index_;
    NSString* caption_;
}

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size;

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size caption:(NSString*)caption;

@end
