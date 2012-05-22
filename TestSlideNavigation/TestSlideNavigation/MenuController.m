//
//  MenuController.m
//  TestSlideNavigation
//
//  Created by matsuda on 12/05/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import "SlideNavigationController.h"

@interface MenuController () <UITableViewDelegate, UITableViewDataSource>
- (void)setupTableView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *menu;
@end

@implementation MenuController

@synthesize tableView = _tableView;
@synthesize menu = _menu;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.menu = [NSArray arrayWithObjects:@"First", @"Second", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupTableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_menu objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ClassIdentifier = [NSString stringWithFormat:@"%@ViewController", [_menu objectAtIndex:indexPath.row]];
    Class klass = NSClassFromString(ClassIdentifier);
    UIViewController *controller = [[klass alloc] initWithNibName:nil bundle:nil];
    [self.slideNavigationController slideOffScreenTo:SlideNavigationControllerSideLeft
                                            complete:^{
                                                CGRect frame = self.slideNavigationController.topViewController.view.frame;
                                                self.slideNavigationController.topViewController = controller;
                                                self.slideNavigationController.topViewController.view.frame = frame;
                                                [self.slideNavigationController resetTopView:SlideNavigationControllerSideLeft];
                                            }];

    // [self.slideNavigationController slideResetTo:SlideNavigationControllerSideLeft];
}

@end
