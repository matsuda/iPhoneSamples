//
//  PolygonViewController.m
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PolygonViewController.h"


@interface PolygonViewController (PrivateMethods)
- (void)effectPolygon;
@end

@implementation PolygonViewController

@synthesize imageView = imageView_, drawButton = drawButton_;

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
    [imageView_ release];
    [drawButton_ release];
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

- (IBAction)didTouchDrawButton:(id)sender
{
    [self effectPolygon];
}

#pragma mark - Private methods

- (void)effectPolygon
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    IplImage *img = 0;
    CvRNG rng = cvRNG (time (NULL));
    CvPoint pt1;
    CvScalar rcolor;
    int irandom;

    // (1)画像領域を確保し初期化する
    img = cvCreateImage (cvSize (320, 320), IPL_DEPTH_8U, 3);
    cvZero (img);

    // (4)円を描画する
    pt1.x = 160;
    pt1.y = 160;
    irandom = cvRandInt (&rng);
    rcolor = CV_RGB (irandom & 255, (irandom >> 8) & 255, (irandom >> 16) & 255);
    cvCircle (img, pt1, 60, rcolor, 1, CV_AA, 0);
    CvRect roi = cvGetImageROI(img);
    NSLog(@"%d", roi.width);

    UIImage *image = [IplImageUtil UIImageFromIplImage:img];
    self.imageView.image = image;

    cvReleaseImage (&img);

    [pool release];
}

@end
