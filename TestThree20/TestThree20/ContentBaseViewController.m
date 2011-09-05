//
//  ContentBaseViewController.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContentBaseViewController.h"

@interface ContentBaseViewController (PrivateMethods)
- (void)replaceNavigationButton;
@end

@implementation ContentBaseViewController

@synthesize delegate = delegate_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self replaceNavigationButton];
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

- (void)replaceNavigationButton
{
    self.title = @"Facebook";
    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithTitle:@"return" style:UIBarButtonItemStyleDone target:self action:@selector(didTapButtonToReturn:)];
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = returnButton;
    [returnButton release];
}

- (void)didTapButtonToReturn:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTapRetunButtonAtContentBaseViewController:)]) {
        [self.delegate didTapRetunButtonAtContentBaseViewController:self];
    } else {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

@end
