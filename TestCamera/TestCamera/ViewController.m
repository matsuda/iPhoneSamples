//
//  ViewController.m
//  TestCamera
//
//  Created by Kosuke Matsuda on 2012/12/25.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "ViewController.h"
#import "ShutterView.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, ShutterViewDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openCamera:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        camera.delegate = self;
        camera.allowsEditing = NO;
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        camera.showsCameraControls = NO;
//        camera.navigationBarHidden = YES;
        if ([[camera.cameraOverlayView subviews] count] == 0) {
            CGRect overlayViewFrame = camera.cameraOverlayView.frame;

            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShutterView class]) owner:nil options:nil];
            ShutterView *shutterView = [nibs objectAtIndex:0];
            CGRect shutterViewFrame = shutterView.frame;
            shutterViewFrame.origin.y = CGRectGetHeight(overlayViewFrame) - CGRectGetHeight(shutterViewFrame);
            shutterView.frame = shutterViewFrame;
            shutterView.delegate = self;
            [shutterView setImage:self.imageView.image];
            [camera.cameraOverlayView addSubview:shutterView];
//            camera.cameraOverlayView = shutterView;

//            overlayViewFrame.size.height = CGRectGetMinY(shutterViewFrame);
//            camera.cameraOverlayView.frame = overlayViewFrame;
        }
        [self presentViewController:camera animated:NO completion:^{}];
        self.imagePickerController = camera;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didTapShutterAtShutterView:(ShutterView *)shutterView
{
    [self.imagePickerController takePicture];
}

- (void)didTapCancelAtShutterView:(ShutterView *)shutterView
{
    [self dismissViewControllerAnimated:NO completion:nil];
    self.imagePickerController = nil;
}

@end
