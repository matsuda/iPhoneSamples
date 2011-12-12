//
//  MultiScrollViewController.m
//  TestMultiScroll
//
//  Created by Kosuke Matsuda on 11/12/12.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MultiScrollViewController.h"

@implementation MultiScrollViewController

@synthesize hScrollView = _hScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    CGRect f = self.hScrollView.bounds;
    NSLog(@"frame >> %@", NSStringFromCGRect(f));
    for (int i = 0; i < 3; i++) {
        UIScrollView *vScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(f.size.width * i, f.origin.y, f.size.width, f.size.height)] autorelease];
        vScrollView.backgroundColor = [UIColor greenColor];
        CGRect sf = vScrollView.bounds;
        NSLog(@"%d : scrollView frame >>> %@", i, NSStringFromCGRect(sf));
        for (int j = 0; j < 3; j++) {
            UIView *v = [[[UIView alloc] initWithFrame:CGRectMake(sf.origin.x, sf.size.height * j, sf.size.width, sf.size.height)] autorelease];
            v.backgroundColor = [UIColor orangeColor];
            UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake((v.frame.size.width - 200) / 2, (v.frame.size.height - 30) / 2, 200, 30)] autorelease];
            label.text = [NSString stringWithFormat:@"Label %d * %d", i, j];
            [vScrollView addSubview:v];
            [v addSubview:label];
        }
        vScrollView.contentSize = CGSizeMake(sf.size.width, sf.size.height * 3);
        [self.hScrollView addSubview:vScrollView];
    }
    self.hScrollView.contentSize = CGSizeMake(f.size.width * 3, f.size.height);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [_hScrollView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
