//
//  ThumbsViewController.m
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/30.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ThumbsViewController.h"
#import "ThumbsTableViewCell.h"

static CGFloat kThumbnailRowHeight = 79.0f;
static CGFloat kThumbSpacing = 4.0f;
static CGFloat kThumbSize = 75.0f;


@interface ThumbsViewController ()
@property (nonatomic, retain) NSMutableArray *thumbs;
- (void)loadthumbs;
- (NSInteger)columnCountForView:(UIView *)view;
@end


@implementation ThumbsViewController

@synthesize tableView = _tableView;
@synthesize thumbs = _thumbs;

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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];

    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.rowHeight = kThumbnailRowHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.thumbs = [NSMutableArray array];
    [self loadthumbs];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tableView = nil;
    self.thumbs = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - PrivateMethods

- (void)loadthumbs
{
    for (int i = 1; i <= 60; i++) {
        UIImage *thumb = [UIImage imageNamed:[NSString stringWithFormat:@"picons%02d.png", i]];
        [self.thumbs addObject:thumb];
    }
}

- (NSInteger)columnCountForView:(UIView *)view
{
    CGFloat width = view.bounds.size.width;
    return floorf( (width - kThumbSpacing * 2) / (kThumbSize + kThumbSpacing) + 0.1 );
}

- (NSMutableArray *)tableView:(UITableView *)tableView thumbsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *thumbs = [NSMutableArray array];
    NSInteger columnCount = [self columnCountForView:tableView];
    NSInteger thumbIndex = indexPath.row * columnCount;
    for (NSInteger i = 0; i < columnCount; i++) {
        UIImage *thumb = [self.thumbs objectAtIndex:thumbIndex];
        if (thumb) {
            [thumbs addObject:thumb];
        } else {
            break;
        }
        thumbIndex += 1;
    }

    return thumbs;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger maxIndex = self.thumbs.count - 1;
    NSInteger columnCount = [self columnCountForView:tableView];
    if (maxIndex < 0) return 0;

    maxIndex += 1;
    NSInteger count = ceil((maxIndex / columnCount) + (maxIndex % columnCount ? 1 : 0));
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    ThumbsTableViewCell *cell = (ThumbsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell = [[[ThumbsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.thumbs = [self tableView:tableView thumbsForRowAtIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableViewDelegate

@end
