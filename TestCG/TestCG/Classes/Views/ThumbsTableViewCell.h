//
//  ThumbsTableViewCell.h
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kThumbSpacing = 5.0f;
static CGFloat kThumbSize = 100.0f;

@interface ThumbsTableViewCell : UITableViewCell

@property (nonatomic, retain) NSArray *thumbs;

@end
