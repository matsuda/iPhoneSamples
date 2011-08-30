//
//  TestLocalNotificationViewController.m
//  TestLocalNotification
//
//  Created by Kosuke Matsuda on 11/08/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestLocalNotificationViewController.h"

@implementation TestLocalNotificationViewController

@synthesize notification = notification_;
@synthesize registerButton = registerButton_, cancelButton = cancelButton_;

- (void)dealloc
{
    [notification_ release];
    [registerButton_ release];
    [cancelButton_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

#pragma mark - Private methods

- (IBAction)registerLocalNotification
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];

    // after 10 seconds
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
    [notification setFireDate:date];

    [notification setTimeZone:[NSTimeZone defaultTimeZone]];

    [notification setAlertBody:@"Local notification test"];

    [notification setSoundName:UILocalNotificationDefaultSoundName];

    [notification setAlertAction:@"Open"];

    [notification setApplicationIconBadgeNumber:10];

    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

    self.notification = notification;
    [notification release];
}

- (IBAction)cancelLocalNotification
{
    [[UIApplication sharedApplication] cancelLocalNotification:self.notification];
}

@end
