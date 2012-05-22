//
//  FirstViewController.m
//  TestSlideNavigation
//
//  Created by matsuda on 12/05/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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
    self.view.backgroundColor = [UIColor lightGrayColor];

    UINavigationItem *naviItem = self.navigationBar.topItem;
    naviItem.title = @"First";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Right" style:UIBarButtonItemStyleDone target:self action:@selector(didTapBarButtonToRight:)];
    naviItem.rightBarButtonItem = rightButton;
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

- (void)didTapBarButtonToRight:(UIBarButtonItem *)sender
{
    [self.slideNavigationController slideTo:SlideNavigationControllerSideRight];
}

@end
