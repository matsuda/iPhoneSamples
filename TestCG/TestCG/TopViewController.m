//
//  TopViewController.m
//  TestCG
//
//  Created by matsuda on 12/06/14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TopViewController.h"
#import "TestCGView.h"

@interface TopViewController ()

@property (strong, nonatomic) TestCGView *testView;
@end

@implementation TopViewController

@synthesize testView = _testView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    TestCGView *testView = [[TestCGView alloc] initWithFrame:CGRectMake(60, 60, 200, 120)];
    self.testView = testView;
    [self.view addSubview:testView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
