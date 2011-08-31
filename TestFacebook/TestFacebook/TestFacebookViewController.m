//
//  TestFacebookViewController.m
//  TestFacebook
//
//  Created by Kosuke Matsuda on 11/08/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestFacebookViewController.h"

static NSString* kAppId = @"202222559841111";


@interface TestFacebookViewController (PrivateMethods)
- (void)initFacebook;
@end


@implementation TestFacebookViewController

@synthesize facebook = facebook_;
@synthesize loginButton = loginButton_;
@synthesize logoutButton = logoutButton_;

- (void)dealloc
{
    [facebook_ release];
    [permissions_ release];
    [loginButton_ release];
    [logoutButton_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initFacebook];
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

#pragma mark - IBAction methods

- (IBAction)didTapButtonToLogin:(id)sender
{
    [facebook_ authorize:permissions_];
}

- (IBAction)didTapButtonToLogout:(id)sender
{
    NSLog(@"logout");
    [facebook_ logout:self];
}

#pragma mark - Private methods

- (void)initFacebook
{
    permissions_ = [[NSArray arrayWithObjects:@"read_stream", @"publish_stream", @"offline_access", nil] retain];
    facebook_ = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
}

#pragma mark - Facebook delegate methods

- (void)fbDidLogin
{
    NSLog(@"logged in Facebook");
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
    NSLog(@"error logged in Facebook");
}

- (void)fbDidLogout
{
    NSLog(@"logged out Facebook");
}

@end
