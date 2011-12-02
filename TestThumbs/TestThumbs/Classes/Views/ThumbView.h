//
//  ThumbView.h
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbView : UIView <NSURLConnectionDataDelegate>

@property (nonatomic, retain) UIImageView *thumbImageView;

- (void)loadImage:(NSString *)url;

@end
