//
//  GroupViewController.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GroupViewController.h"


@implementation GroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[TTNavigator navigator] setDelegate:self];
    }
    TTDPRINT(@"GroupViewController");
    return self;
}

- (void)dealloc
{
    [[TTNavigator navigator] setDelegate:nil];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TTNavigatorDelegate methods

- (void)navigator:(TTBaseNavigator *)navigator willOpenURL:(NSURL *)URL inViewController:(UIViewController *)controller
{
    TTDPRINT(@"willOpenURL");
}

@end
