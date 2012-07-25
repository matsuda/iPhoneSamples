//
//  RectViewController.m
//  TestCG
//
//  Created by matsuda on 12/07/25.
//
//

#import "CropViewController.h"

#import "UIImage+Crop.h"

@interface CropViewController ()

@end

@implementation CropViewController

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
    UIImage *image = [UIImage imageNamed:@"sample"];
    UIImage *croppedImage = [image crop:CGRectMake(30, 80, 200, 100)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:croppedImage];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
