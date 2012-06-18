//
//  TweetViewController.m
//  TestTwitter
//
//  Created by matsuda on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TweetViewController.h"
#import <Twitter/Twitter.h>

@interface TweetViewController ()

@end

@implementation TweetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)tweet:(id)sender
{
    TWTweetComposeViewController *tweetTweetViewController = [[TWTweetComposeViewController alloc] init];
    [self presentModalViewController:tweetTweetViewController animated:YES];
}

@end
