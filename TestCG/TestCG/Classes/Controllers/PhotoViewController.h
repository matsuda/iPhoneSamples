//
//  PhotoViewController.h
//  TestCG
//
//  Created by Kosuke Matsuda on 11/11/28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImage *originalImage;
@property (nonatomic, retain) UIScrollView *scrollView;

@end
