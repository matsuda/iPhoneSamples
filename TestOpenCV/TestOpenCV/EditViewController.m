//
//  EditViewController.m
//  TestOpenCV
//
//  Created by Kosuke Matsuda on 11/08/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController (PrivateMethods)
// setup
- (void)setupSlider;
- (void)toggleControl:(BOOL)hidden;
// image
- (void)effectSepia;
@end

@implementation EditViewController

@synthesize ySlider = ySlider_, rSlider = rSlider_, gSlider = gSlider_, bSlider = bSlider_;
@synthesize resetButton = resetButton_;

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
	[ySlider_ release];
	[rSlider_ release];
	[gSlider_ release];
	[bSlider_ release];
	[resetButton_ release];
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
	[self setupSlider];
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

#pragma mark - Private methods

- (void)setupSlider
{
	[self toggleControl:YES];
	self.rSlider.minimumValue = self.gSlider.minimumValue = self.bSlider.minimumValue = self.ySlider.minimumValue = -255.f;
	self.rSlider.maximumValue = self.gSlider.maximumValue = self.bSlider.maximumValue = self.ySlider.maximumValue = 255.f;
	self.rSlider.value = self.gSlider.value = self.bSlider.value = self.ySlider.value = 0.f;
	self.rSlider.continuous = self.gSlider.continuous = self.bSlider.continuous = self.ySlider.continuous = NO;
	
	self.bSlider.tag = sliderTagBlue;
	self.gSlider.tag = sliderTagGreen;
	self.rSlider.tag = sliderTagRed;
	self.ySlider.tag = sliderTagGray;
	
	[self.rSlider addTarget:self action:@selector(didChangeValueSlider:) forControlEvents:UIControlEventValueChanged];
	[self.gSlider addTarget:self action:@selector(didChangeValueSlider:) forControlEvents:UIControlEventValueChanged];
	[self.bSlider addTarget:self action:@selector(didChangeValueSlider:) forControlEvents:UIControlEventValueChanged];
	[self.ySlider addTarget:self action:@selector(didChangeValueSlider:) forControlEvents:UIControlEventValueChanged];
	
	[self.resetButton addTarget:self action:@selector(didTouchUpInsideResetButton:) forControlEvents:UIControlEventTouchUpInside];

    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
    self.ySlider.transform = trans;
}

- (void)toggleControl:(BOOL)hidden
{
	self.rSlider.hidden = self.gSlider.hidden = self.bSlider.hidden = self.ySlider.hidden = self.resetButton.hidden = hidden;
}

- (void)effectSepia
{
	if (!imageView_.image) return;
	
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	IplImage *srcImg = [IplImageUtil CreateIplImageFromUIImage:self.originalImage];
	// IplImage *srcImg = [IplImageUtil CreateIplImageFromUIImage:imageView_.image];
	IplImage *grayImg = cvCreateImage(cvGetSize(srcImg), IPL_DEPTH_8U, 1);
	IplImage *dstImg = cvCreateImage(cvGetSize(srcImg), IPL_DEPTH_8U, 3);
	
	// グレースケール化
	cvCvtColor(srcImg, grayImg, CV_RGB2GRAY);
	cvReleaseImage(&srcImg);
	
	int yColor = self.ySlider.value;
	int rColor = self.rSlider.value;
	int gColor = self.gSlider.value;
	int bColor = self.bSlider.value;
    NSLog(@"slider >>> gray : %d, red : %d, green : %d, blue : %d", yColor, rColor, gColor, bColor);
	
	// const int darkness = 50;
	for (int y = 0; y < grayImg->height; y++) {
		for (int x = 0; x < grayImg->width; x++){
			int g = PIXVAL(grayImg, x, y) + yColor;
			PIXVAL(grayImg, x, y) = (g > 255) ? 255 : ( (g < 0) ? 0 : g );
		}
	}
	
	cvCvtColor(grayImg, dstImg, CV_GRAY2RGB);
	// セピア色をつける
	for (int y = 0; y < dstImg->height; y++){
		for (int x = 0; x < dstImg->width; x++){
			int r = PIXVALR(dstImg, x, y) + rColor;
			int g = PIXVALG(dstImg, x, y) + gColor;
			int b = PIXVALB(dstImg, x, y) + bColor;
			PIXVALR(dstImg, x, y) = (r > 255) ? 255 : ( (r < 0) ? 0 : r );
			PIXVALG(dstImg, x, y) = (g > 255) ? 255 : ( (g < 0) ? 0 : g );
			PIXVALB(dstImg, x, y) = (b > 255) ? 255 : ( (b < 0) ? 0 : b );
		}
	}
	cvReleaseImage(&grayImg);
	
	// 表示
	imageView_.image = [IplImageUtil UIImageFromIplImage:dstImg];
	cvReleaseImage(&dstImg);
	
	[pool release];
}

- (void)didChangeValueSlider:(UISlider *)sender
{
	switch (sender.tag) {
		case sliderTagBlue:
			self.bSlider.value = sender.value;
			break;
		case sliderTagGreen:
			self.gSlider.value = sender.value;
			break;
		case sliderTagRed:
			self.rSlider.value = sender.value;
			break;
		case sliderTagGray:
			self.ySlider.value = sender.value;
			break;
	}
	[self effectSepia];
}

- (void)didTouchUpInsideResetButton:(UIButton *)sender
{
	imageView_.image = self.originalImage;
	self.rSlider.value = self.gSlider.value = self.bSlider.value = self.ySlider.value = 0.f;
}

@end
