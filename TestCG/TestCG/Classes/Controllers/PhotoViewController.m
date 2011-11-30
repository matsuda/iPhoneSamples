//
//  PhotoViewController.m
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
- (void)setupScrollView;
- (void)setIcons;
- (void)selectPhoto;
- (void)setupNavigationBar;
- (NSString *)documentDirectoryPath:(NSString *)fileName;
- (BOOL)writeImage:(UIImage *)image toFile:(NSString *)fileName;
- (UIImage *)imageFromFile:(NSString *)fileName;
@end

@implementation PhotoViewController

@synthesize imageView = _imageView;
@synthesize originalImage = _originalImage;
@synthesize scrollView = _scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] autorelease];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.imageView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupScrollView];
    [self setIcons];
    if (self.originalImage) {
        self.imageView.image = self.originalImage;
    } else {
        [self selectPhoto];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.imageView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_imageView release];
    [_originalImage release];
    [_scrollView release];
    [super dealloc];
}
#pragma mark - Private methods

- (void)setupScrollView
{
    CGRect rect = CGRectMake(0, 352, self.view.bounds.size.width, 0);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    // scrollView.contentOffset = CGPointMake(self.view.bounds.size.width * currentIndex, 0);
    scrollView.backgroundColor = [UIColor whiteColor];
    // scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;

    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView release];
}

- (void)setIcons
{
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    CGPoint p = CGPointZero;

    for (int i = 0; i < 10; i++) {
        UIImage *icon = [UIImage imageNamed:[NSString stringWithFormat:@"image%04d.png", i + 1]];

        CGRect rect = iconView.frame;
        rect.size.width += icon.size.width;
        rect.size.height = icon.size.height;
        iconView.frame = rect;

        /*
         imageとして表示する場合
        UIImageView *imageView = [[UIImageView alloc] initWithImage:icon];
        CGRect imageViewRect = CGRectMake(p.x, p.y, icon.size.width, icon.size.height);
        imageView.frame = imageViewRect;
        [iconView addSubview:imageView];
        [imageView release];
         */

        // buttonとして表示
        CGRect buttonRect = CGRectMake(p.x, p.y, icon.size.width, icon.size.height);
        UIButton *button = [[UIButton alloc] initWithFrame:buttonRect];
        [button setImage:icon forState:UIControlStateNormal];
        [iconView addSubview:button];
//        [self setActionToButton:button index:i];
        [button release];

        p.x += icon.size.width;
        [icon release];
    }

    CGRect rect = self.scrollView.frame;
    rect.size.height = iconView.frame.size.height;
    self.scrollView.frame = rect;
    [self.scrollView addSubview:iconView];
    self.scrollView.contentSize = iconView.bounds.size;

    [iconView release];
}

- (void)selectPhoto
{
    UIActionSheet *camerasheet = [[UIActionSheet alloc] initWithTitle:@"画像を選択" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"カメラロール", @"カメラ", nil];
    camerasheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [camerasheet showInView:self.view];
    [camerasheet release];
}

- (void)setupNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(didTapCameraButton:)] autorelease];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(didTapToSaveImage:)] autorelease];
}

- (NSString *)documentDirectoryPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:fileName];
}

- (BOOL)writeImage:(UIImage *)image toFile:(NSString *)fileName
{
    NSString *filePath = [self documentDirectoryPath:fileName];
    NSData *data = UIImagePNGRepresentation(image);
    return [data writeToFile:filePath atomically:YES];
}

- (UIImage *)imageFromFile:(NSString *)fileName
{
    NSString *filePath = [self documentDirectoryPath:fileName];
    return [UIImage imageWithContentsOfFile:filePath];
}

- (void)didTapCameraButton:(id)sender
{
    [self selectPhoto];
}

- (void)didTapToSaveImage:(id)sender
{
    if (self.originalImage) {
        [self writeImage:self.originalImage toFile:@"test_cg.png"];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"画像保存" message:@"画像が選択されていません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
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
    UIImagePickerController *imagePicker = [[UIImagePickerController new] autorelease];
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)dismissImagePickerController:(UIImagePickerController *)picker
{
    if ([picker respondsToSelector:@selector(presentingViewController)]) {
        [[picker presentingViewController] dismissModalViewControllerAnimated:YES];
    } else {
        [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    }
    // [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.originalImage = originalImage;
    self.imageView.image = self.originalImage;
    [self dismissImagePickerController:picker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissImagePickerController:picker];
}

@end
