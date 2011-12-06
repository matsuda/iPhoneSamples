//
//  KMCarouselViewController.m
//  TestCarousel
//
//  Created by Kosuke Matsuda on 11/12/05.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "KMCarouselViewController.h"

@implementation KMCarouselViewController

@synthesize carouselView = _carouselView;

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
    self.carouselView = [[[KMCarouselView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 74)] autorelease];
    self.carouselView.dataSource = self;
    self.carouselView.delegate = self;
    [self.view addSubview:self.carouselView];

    KMCarouselView *cv2 = [[[KMCarouselView alloc] initWithFrame:CGRectMake(20, 200, 280, 74)] autorelease];
    cv2.dataSource = self;
    cv2.delegate = self;
    [self.view addSubview:cv2];

    KMCarouselView *cv3 = [[[KMCarouselView alloc] initWithFrame:CGRectMake(20, 350, 280, 74)] autorelease];
    cv3.dataSource = self;
    cv3.delegate = self;
    [self.view addSubview:cv3];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.carouselView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfItemsInCarouselView:(KMCarouselView *)carouselView
{
    return 10;
}

- (void)didTapButton:(id)sender
{
    NSLog(@"didTapButton");
}
- (void)setActionToButton:(UIButton *)button atIndex:(NSInteger)index
{
    [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIView *)carouselViewItemAtIndex:(NSInteger)index
{
    UIImage *icon = [UIImage imageNamed:[NSString stringWithFormat:@"image%04d.png", index + 1]];

    // buttonとして表示
    CGRect buttonRect = CGRectMake(0, 0, icon.size.width, icon.size.height);
    UIButton *button = [[[UIButton alloc] initWithFrame:buttonRect] autorelease];
    [button setImage:icon forState:UIControlStateNormal];
    [self setActionToButton:button atIndex:index];
    return button;

    // imageとして表示する場合
//    UIImageView *imageView = [[[UIImageView alloc] initWithImage:icon] autorelease];
//    CGRect imageViewRect = CGRectMake(0, 0, icon.size.width, icon.size.height);
//    imageView.frame = imageViewRect;
//    return imageView;
}

- (void)carouselView:(KMCarouselView *)carouselView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"carouselView:didSelectItemAtIndex:");
}

@end
