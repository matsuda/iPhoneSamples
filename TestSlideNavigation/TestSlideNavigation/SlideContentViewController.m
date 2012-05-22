//
//  SlideContentViewController.m
//  TestSlideNavigation
//
//  Created by matsuda on 12/05/22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SlideContentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SlideContentViewController ()
- (void)setupNavigationBar;
@end

@implementation SlideContentViewController

@synthesize navigationBar = _navigationBar;

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
    [self setupNavigationBar];
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
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

- (void)setupNavigationBar
{
    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *naviItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(didTapBarButtonToLeft:)];
    naviItem.leftBarButtonItem = leftButton;
    [naviBar pushNavigationItem:naviItem animated:YES];
    [self.view addSubview:naviBar];
    self.navigationBar = naviBar;
}

- (void)didTapBarButtonToLeft:(UIBarButtonItem *)sender
{
    [self.slideNavigationController slideTo:SlideNavigationControllerSideLeft];
}

@end
