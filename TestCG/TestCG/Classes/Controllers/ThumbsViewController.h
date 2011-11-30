//
//  ThumbsViewController.h
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;

@end
