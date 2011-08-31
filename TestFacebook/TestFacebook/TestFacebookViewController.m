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
//    [facebook_ authorize:permissions_];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:kAppId, @"client_id", @"touch", @"display", @"publish_stream,read_stream,offline_access", @"scope", nil];
    [facebook_ dialog:@"oauth" andParams:params andDelegate:self];
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

#pragma mark - FBSessionDelegate methods

/**
 * Called when the user successfully logged in.
 */
- (void)fbDidLogin
{
    MSLog;
}

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)fbDidNotLogin:(BOOL)cancelled
{
    MSLog;
}

/**
 * Called when the user logged out.
 */
- (void)fbDidLogout
{
    MSLog;
}

#pragma mark - FBDialogDelegate methods

/**
 * Called when the dialog succeeds and is about to be dismissed.
 */
- (void)dialogDidComplete:(FBDialog *)dialog
{
    MSLog;
}

/**
 * Called when the dialog succeeds with a returning url.
 */
- (void)dialogCompleteWithUrl:(NSURL *)url
{
    MSLog;
}

/**
 * Called when the dialog get canceled by the user.
 */
- (void)dialogDidNotCompleteWithUrl:(NSURL *)url
{
    MSLog;
}

/**
 * Called when the dialog is cancelled and is about to be dismissed.
 */
- (void)dialogDidNotComplete:(FBDialog *)dialog
{
    MSLog;
}

/**
 * Called when dialog failed to load due to an error.
 */
- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error
{
    MSLog;
}

/**
 * Asks if a link touched by a user should be opened in an external browser.
 *
 * If a user touches a link, the default behavior is to open the link in the Safari browser,
 * which will cause your app to quit.  You may want to prevent this from happening, open the link
 * in your own internal browser, or perhaps warn the user that they are about to leave your app.
 * If so, implement this method on your delegate and return NO.  If you warn the user, you
 * should hold onto the URL and once you have received their acknowledgement open the URL yourself
 * using [[UIApplication sharedApplication] openURL:].
 */
//- (BOOL)dialog:(FBDialog*)dialog shouldOpenURLInExternalBrowser:(NSURL *)url
//{
//}

@end
