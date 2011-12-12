//
//  MultiScrollViewController.h
//  TestMultiScroll
//
//  Created by Kosuke Matsuda on 11/12/12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiScrollViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic, retain) IBOutlet UIScrollView *hScrollView;
@end
