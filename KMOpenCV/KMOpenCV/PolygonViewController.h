//
//  PolygonViewController.h
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IplImageUtil.h"
#import "UIImage+Resize.h"

@interface PolygonViewController : UIViewController {
    UIImageView *imageView_;
    UIButton *drawButton_;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *drawButton;

- (IBAction)didTouchDrawButton:(id)sender;

@end
