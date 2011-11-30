//
//  ThumbsTableViewCell.h
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbsTableViewCell : UITableViewCell {
    CGFloat _thumbSize;
    CGPoint _thumbOrigin;
    NSInteger _columnCount;
}

@property (nonatomic, retain) NSArray *thumbs;
@property (nonatomic) CGFloat thumbSize;
@property (nonatomic) CGPoint thumbOrigin;
@property (nonatomic) NSInteger columnCount;

@end
