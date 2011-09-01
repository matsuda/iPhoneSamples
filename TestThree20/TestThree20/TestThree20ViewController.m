//
//  TestThree20ViewController.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/08/31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestThree20ViewController.h"

#import "MenuViewController.h"

@implementation TestThree20ViewController
@synthesize button = button_;

- (void)dealloc
{
    [button_ release];
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

- (IBAction)didTapButton:(id)sender
{
//    TTOpenURL(@"tt://menu/1");
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:@"tt://menu"]];

//    MenuViewController *controller = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
//    [self.navigationController pushViewController:controller animated:YES];
//    [controller release];
}

@end
