//
//  ViewController.m
//  TestChart
//
//  Created by Kosuke Matsuda on 2012/11/01.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "CircleGraph.h"
#import "LineGraph.h"
#import "Chart.h"


@interface ViewController ()
@property (weak, nonatomic) CircleGraph *circleGraph;
@property (weak, nonatomic) LineGraph *lineGraph;
@property (weak, nonatomic) Chart *chart;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];

    [self addCircleGraph];
    [self addLineGraph];
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

- (void)addCircleGraph
{
    CGPoint point = CGPointMake(42, 50);
    CGSize size = CGSizeMake(200, 200);
    CircleGraph *graph = [[CircleGraph alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    [self.view addSubview:graph];
    self.circleGraph = graph;
}

- (void)addLineGraph
{
    CGPoint point = CGPointMake(284, 50);
    CGSize size = CGSizeMake(200, 200);
    LineGraph *graph = [[LineGraph alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    [self.view addSubview:graph];
    self.lineGraph = graph;
}

@end
