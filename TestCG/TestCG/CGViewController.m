//
//  TestCGViewController.m
//  TestCG
//
//  Created by matsuda on 12/06/14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CGViewController.h"
#import "CGView.h"

@interface CGViewController ()

@property (strong, nonatomic) CGView *testView;
@end

@implementation CGViewController

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
    CGView *testView = [[CGView alloc] initWithFrame:CGRectMake(60, 60, 200, 120)];
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
