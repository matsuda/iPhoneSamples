//
//  FilterViewController.m
//  TestCG
//
//  Created by matsuda on 12/07/25.
//
//

#import "FilterViewController.h"

#import "UIImage+Filter.h"

@interface FilterViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *originalImageView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation FilterViewController

@synthesize originalImageView = _originalImageView;
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
    UIImage *originalImage = self.originalImageView.image;
//    UIImage *image = [originalImage grayImage:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
    NSLog(@"size >>>>>>>>>>>>>>>> %@", NSStringFromCGSize(originalImage.size));
    UIImage *image = [originalImage gradationImage:CGRectMake(0, 0, 220, 220)];
//    UIImage *image = [originalImage averageFilter:1 toRect:CGRectMake(0, 0, 120, 120)];
    self.imageView.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
