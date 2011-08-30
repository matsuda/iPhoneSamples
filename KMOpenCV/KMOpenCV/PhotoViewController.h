//
//  PhotoViewController.h
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IplImageUtil.h"
#import "UIImage+Resize.h"

#define zPhotoViewControllerImageCellSize        CGSizeMake(320, 240)

#define PIXVAL(iplimagep, x, y) (*(uchar *)((iplimagep)->imageData + (y) * (iplimagep)->widthStep + (x)))
#define PIXVALB(iplimagep, x, y) (*(uchar *)((iplimagep)->imageData + (y) * (iplimagep)->widthStep + (x)*3+0))
#define PIXVALG(iplimagep, x, y) (*(uchar *)((iplimagep)->imageData + (y) * (iplimagep)->widthStep + (x)*3+1))
#define PIXVALR(iplimagep, x, y) (*(uchar *)((iplimagep)->imageData + (y) * (iplimagep)->widthStep + (x)*3+2))

@interface PhotoViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

    UIImageView *imageView_;
    UIToolbar *toolbar_;
	UIImage *originalImage_;
}

@property (nonatomic, retain) UIImage *originalImage;

// setup
- (void)setupToolbar;
- (void)setupImageView:(UIImage *)image;
- (void)toggleControl:(BOOL)hidden;

@end
