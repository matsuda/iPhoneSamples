//
//  GestureViewController.m
//  TestPinch
//
//  Created by matsuda on 12/07/24.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end

@implementation GestureViewController

@synthesize imageView = _imageView;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
