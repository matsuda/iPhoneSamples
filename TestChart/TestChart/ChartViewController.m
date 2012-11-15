//
//  ChartViewController.m
//  TestChart
//
//  Created by Kosuke Matsuda on 2012/11/02.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ChartViewController.h"
#import "Chart.h"

@interface ChartViewController () <ChartDataSource, ChartDelegate>

@end

@implementation ChartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setupChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissController:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupChart
{
    CGPoint point = CGPointMake(84, 300);
    CGSize size = CGSizeMake(600, 300);
    Chart *chart = [[Chart alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    chart.dataSource = self;
    [self.view addSubview:chart];
    self.chart = chart;
}

- (NSInteger)numberOfXAxisInChart:(Chart *)chart
{
    return 3;
}

- (NSInteger)numberOfYAxisInChart:(Chart *)chart
{
    return 5;
}

- (NSString *)chart:(Chart *)chart cellAtCoordinate:(ChartCoordinate)coordinate
{
    return @"test テスト";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
