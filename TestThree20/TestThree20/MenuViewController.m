//
//  MenuViewController.m
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/09/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"


@implementation MenuViewController

//- (id)init
//{
//    NSLog(@"mmmmmmmmmmmmmmmmmmmmmmm");
//    if (self = [super init]) {
//        self.hidesBottomBarWhenPushed = YES;
//    }
//    return self;
//}

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Facebook";
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

- (void)loadSearchBar
{
    TTTableViewController* searchController = [[[TTTableViewController alloc] init] autorelease];
    // searchController.dataSource = [[[MockSearchDataSource alloc] initWithDuration:1.5] autorelease];
    self.searchViewController = searchController;
    _searchController.searchBar.frame = CGRectMake(0, 0, 320, 44);
    [self.view addSubview:_searchController.searchBar];
}
//- (void)loadLauncherView
//{
//    launcherView_ = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
//    launcherView_.backgroundColor = [UIColor blackColor];
//    launcherView_.delegate = self;
//    launcherView_.columnCount = 4;
//    launcherView_.persistenceMode = TTLauncherPersistenceModeAll;
//    launcherView_.frame = CGRectMake(0, 44, 320, self.view.frame.size.height - 44);
//    
//    if (![launcherView_ restoreLauncherItems]) {
//        launcherView_.pages = [NSArray arrayWithObjects:
//                               [NSArray arrayWithObjects:
//                                [[[TTLauncherItem alloc] initWithTitle:@"Button 1"
//                                                                 image:@"bundle://Icon.png"
//                                                                   URL:nil canDelete:YES] autorelease],
//                                [[[TTLauncherItem alloc] initWithTitle:@"Button 2"
//                                                                 image:@"bundle://Icon.png"
//                                                                   URL:nil canDelete:YES] autorelease],
//                                [[[TTLauncherItem alloc] initWithTitle:@"Button 3"
//                                                                 image:@"bundle://Icon.png"
//                                                                   URL:@"fb://item3" canDelete:YES] autorelease],
//                                [[[TTLauncherItem alloc] initWithTitle:@"Button 4"
//                                                                 image:@"bundle://Icon.png"
//                                                                   URL:@"fb://item4" canDelete:YES] autorelease],
//                                [[[TTLauncherItem alloc] initWithTitle:@"Button 5"
//                                                                 image:@"bundle://Icon.png"
//                                                                   URL:@"fb://item5" canDelete:YES] autorelease],
//                                [[[TTLauncherItem alloc] initWithTitle:@"Button 6"
//                                                                 image:@"bundle://Icon.png"
//                                                                   URL:@"fb://item6" canDelete:YES] autorelease],
//                                [[[TTLauncherItem alloc] initWithTitle:@"Button 7"
//                                                                 image:@"bundle://Icon.png"
//                                                                   URL:@"fb://item7" canDelete:YES] autorelease],
//                                nil],
//                               [NSArray arrayWithObjects:
//                                [[[TTLauncherItem alloc] initWithTitle:@"Button 8"
//                                                                 image:@"bundle://Icon.png"
//                                                                   URL:nil canDelete:YES] autorelease],
//                                [[[TTLauncherItem alloc] initWithTitle:@"Button 9"
//                                                                 image:@"bundle://Icon.png"
//                                                                   URL:nil canDelete:YES] autorelease],
//                                nil],
//                               nil
//                               ];
//    }
//    [self.view addSubview:launcherView_];
//    
//    TTLauncherItem* item = [launcherView_ itemWithURL:@"fb://item3"];
//    NSLog(@"%@", [item class]);
//    item.badgeNumber = 4;
//    
//    item = [launcherView_ itemWithURL:@"fb://item4"];
//    item.badgeNumber = 0;
//    
//    item = [launcherView_ itemWithURL:@"fb://item5"];
//    item.badgeValue = @"100!";
//    
//    item = [launcherView_ itemWithURL:@"fb://item6"];
//    item.badgeValue = @"Off";
//    
//    item = [launcherView_ itemWithURL:@"fb://item7"];
//    item.badgeNumber = 300;
//}
- (void)loadLauncherView
{
    launcherView_ = [[TTLauncherView alloc] initWithFrame:self.view.bounds];
    launcherView_.delegate = self;
    launcherView_.columnCount = 3;
    launcherView_.persistenceMode = TTLauncherPersistenceModeAll;
    launcherView_.frame = CGRectMake(0, 44, 320, self.view.frame.size.height - 44);

    if (![launcherView_ restoreLauncherItems]) {
        launcherView_.pages = [NSArray arrayWithObjects:
                               [NSArray arrayWithObjects:
                                [[[TTLauncherItem alloc] initWithTitle:@"Feed"
                                                                 image:@"bundle://Icon.png"
                                                                   URL:@"tt://feed" canDelete:NO] autorelease],
                                [[[TTLauncherItem alloc] initWithTitle:@"Photo"
                                                                 image:@"bundle://Icon.png"
                                                                   URL:@"tt://photo" canDelete:NO] autorelease],
                                [[[TTLauncherItem alloc] initWithTitle:@"Notice"
                                                                 image:@"bundle://Icon.png"
                                                                   URL:@"tt://notice" canDelete:NO] autorelease],
                                nil],
                               nil];
    }
    [self.view addSubview:launcherView_];
}

- (void)loadView
{
    [super loadView];

    [self loadSearchBar];
    [self loadLauncherView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTLauncherViewDelegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
    // in case of Facebook animations
    // http://stackoverflow.com/questions/6845466/three20-ttlauncher-animations-transitions
    //
    [[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:item.URL] applyAnimated:YES]];
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
    [self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                 target:launcherView_ action:@selector(endEditing)] autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

@end
