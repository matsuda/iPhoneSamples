//
//  TTThumbsViewController+PlayQme.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@implementation TTThumbsViewController (PlayQme)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.statusBarStyle = UIStatusBarStyleBlackTranslucent;
//        self.navigationBarStyle = UIBarStyleBlackTranslucent;
//        self.navigationBarTintColor = nil;
//        self.wantsFullScreenLayout = YES;
//        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)updateTableLayout {
    NSLog(@"sssssssssssss");
    NSLog(@"%d", TTBarsHeight());
    self.tableView.contentInset = UIEdgeInsetsMake(44+4, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(TTBarsHeight(), 0, 0, 0);
}

@end
