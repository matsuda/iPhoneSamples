//
//  PhotoViewController.m
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"


@interface PhotoViewController (PrivateMethods)
@end


@implementation PhotoViewController

@synthesize originalImage = originalImage_;

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
    [toolbar_ release];
	[originalImage_ release];
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
    self.view.backgroundColor = [UIColor blackColor];
    [self setupToolbar];
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

- (void)setupToolbar
{
    toolbar_ = [UIToolbar new];
    toolbar_.barStyle = UIBarStyleBlackOpaque;
    [toolbar_ sizeToFit];
    toolbar_.frame = CGRectMake(0, 0, 320, 44);
	
    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(didTappedCameraButton:)];
	
    // [toolbar_ setItems:[NSArray arrayWithObjects:cameraButton, effectButton, nil]];
    [toolbar_ setItems:[NSArray arrayWithObjects:cameraButton, nil]];
    [cameraButton release];
    [self.view addSubview:toolbar_];
}

- (void)setupImageView:(UIImage *)image
{
    if (imageView_) {
        [imageView_ removeFromSuperview];
        [imageView_ release], imageView_ = nil;
    }
    CGSize size = [image resizedSize:zPhotoViewControllerImageCellSize];
    // imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - size.width) / 2, (self.view.frame.size.height - size.height) / 2, size.width, size.height)];
    imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - size.width) / 2, 50, size.width, size.height)];
    imageView_.image = image;
    imageView_.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView_];
}

- (void)toggleControl:(BOOL)hidden
{
}

- (void)didTappedCameraButton:(id)sender
{
    UIActionSheet *camerasheet = [[UIActionSheet alloc] initWithTitle:@"画像を選択" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"カメラロール", @"カメラ", nil];
    camerasheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [camerasheet showInView:self.view];
    [camerasheet release];
}

#pragma mark - UIActionSheetDelegate methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger cancelButtonIndex = actionSheet.cancelButtonIndex;
    if (buttonIndex == cancelButtonIndex)
        return;
    
    UIImagePickerControllerSourceType sourceType = 0;
    switch (buttonIndex) {
        case 0: {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        case 1: {
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
    }
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [self presentModalViewController:imagePicker animated:YES];
    [imagePicker release];
}

#pragma UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    // UIImage *shrinkedImage = [originalImage resizedImage:zPhotoViewControllerImageCellSize];
    UIImage *shrinkedImage = [originalImage resizedImage:zPhotoViewControllerImageCellSize];
    [self setupImageView:shrinkedImage];
	self.originalImage = shrinkedImage;
	
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
	[self toggleControl:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

@end
