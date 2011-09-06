//
//  PhotoViewController.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/02.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TTThumbsViewController+PlayQme.m"
//#import <Three20UI/UIViewAdditions.h>

#import "PhotoViewController.h"

#import "MockPhoto.h"
#import "MockPhotoSource.h"

@interface PhotoViewController (PrivateMethods)
- (void)setupNavigationBar;
- (void)setupTabBar;
- (void)setupPhotoList;
- (void)setupPhotoSource;
@end

@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // [self setupPhotoList];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(tabBar_);
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)didTapTitleBarToSelectCategory:(id)sender
{
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didTapButtonToReturn:(id)sender
{
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didTapButtonToPost:(id)sender
{
    TTDPRINT(@"u");
}
- (void)loadView
{
    [super loadView];
    [self setupTabBar];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupPhotoSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNavigationBar];
    tabBar_.hidden = NO;
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

- (void)setupNavigationBar
{
    self.navigationController.navigationBar.hidden = YES;
    
    UINavigationBar* naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    UIButton* titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [titleButton addTarget:self action:@selector(didTapTitleBarToSelectCategory:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.highlighted = YES;

    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 198, 42)];
    titleLabel.text = @"Facebook";
    titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.backgroundColor = [UIColor orangeColor];
    [titleButton addSubview:titleLabel];
    [titleLabel release];

    UINavigationItem* titleItem = [[UINavigationItem alloc] initWithTitle:@"hoge"];
    titleItem.titleView = titleButton;
    
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonSystemItemCancel target:self action:@selector(didTapButtonToReturn:)];
    titleItem.leftBarButtonItem = leftButton;
    [leftButton release];
    
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(didTapButtonToPost:)];
    titleItem.rightBarButtonItem = rightButton;
    [rightButton release];
    
    [naviBar pushNavigationItem:titleItem animated:YES];
    [titleItem release];
    
    [self.view addSubview:naviBar];
    [naviBar release];
}

- (void)setupTabBar
{
	CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;

    tabBar_ = [[TTTabStrip alloc] initWithFrame:CGRectMake(0, 44, applicationFrame.size.width, 41)];
    tabBar_.tabItems = [NSArray arrayWithObjects:
                        [[[TTTabItem alloc] initWithTitle:@"ALL"] autorelease],
                        [[[TTTabItem alloc] initWithTitle:@"OFFICIAL"] autorelease],
                        [[[TTTabItem alloc] initWithTitle:@"SHOP"] autorelease],
                        [[[TTTabItem alloc] initWithTitle:@"SHOP"] autorelease],
                        [[[TTTabItem alloc] initWithTitle:@"SHOP"] autorelease],
                        [[[TTTabItem alloc] initWithTitle:@"TEAM"] autorelease],
                        nil];
    [self.view addSubview:tabBar_];
    tabBar_.hidden = YES;
}
- (void)setupPhotoList
{
    self.title = @"Photo";

    TTListDataSource *dataSource = [[[TTListDataSource alloc] init] autorelease];

    NSMutableArray *contents = [NSMutableArray arrayWithObjects:
                                [TTTableTextItem itemWithText:@"Item1" URL:[NSString stringWithFormat:@"tt://photo/%d", 1]],
                                [TTTableTextItem itemWithText:@"Item2" URL:[NSString stringWithFormat:@"tt://photo/%d", 2]],
                                [TTTableTextItem itemWithText:@"Item3" URL:[NSString stringWithFormat:@"tt://photo/%d", 3]],
                                nil];
    [dataSource.items addObjectsFromArray:contents];
    self.dataSource = dataSource;
}

- (void)setupPhotoSource
{
    self.photoSource = [[MockPhotoSource alloc]
                        initWithType:MockPhotoSourceNormal
                        //initWithType:MockPhotoSourceDelayed
                        // initWithType:MockPhotoSourceLoadError
                        // initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
                        title:@"Flickr Photos"
                        photos:[[NSArray alloc] initWithObjects:
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
                                  smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
                                  size:CGSizeMake(500, 372)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
                                  size:CGSizeMake(391, 500)] autorelease],
                                
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
                                  smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
                                  size:CGSizeMake(500, 372)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
                                  size:CGSizeMake(391, 500)] autorelease],
                                
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
                                  smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
                                  size:CGSizeMake(500, 372)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
                                  size:CGSizeMake(391, 500)] autorelease],
                                
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
                                  smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
                                  size:CGSizeMake(500, 372)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
                                  size:CGSizeMake(391, 500)] autorelease],
                                
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
                                  size:CGSizeMake(960, 1280)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
                                  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
                                  size:CGSizeMake(320, 480)
                                  caption:@"A hike."] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
                                  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
                                  size:CGSizeMake(320, 480)] autorelease],
                                
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
                                  smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
                                  size:CGSizeMake(383, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
                                  size:CGSizeMake(391, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
                                  size:CGSizeMake(407, 500)] autorelease],
                                [[[MockPhoto alloc]
                                  initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
                                  smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
                                  size:CGSizeMake(500, 406)] autorelease],
                                
                                nil
                                ]
                        photos2:nil
                        ];
}




@end
