//
//  ViewController.m
//  TestChart
//
//  Created by Kosuke Matsuda on 2012/11/01.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "CircleChart.h"
#import "LineChart.h"


@interface ViewController ()
@property (weak, nonatomic) CircleChart *circleChart;
@property (weak, nonatomic) LineChart *lineChart;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];

    [self addCircleChart];
    [self addLineChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}

- (void)addCircleChart
{
    CGPoint point = CGPointMake(42, 50);
    CGSize size = CGSizeMake(200, 200);
    CircleChart *chart = [[CircleChart alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    [self.view addSubview:chart];
    self.circleChart = chart;
}

- (void)addLineChart
{
    CGPoint point = CGPointMake(284, 50);
    CGSize size = CGSizeMake(200, 200);
    LineChart *chart = [[LineChart alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    [self.view addSubview:chart];
    self.lineChart = chart;
}

@end
