//
//  EditViewController.h
//  KMOpenCV
//
//  Created by Kosuke Matsuda on 11/08/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PhotoViewController.h"

#define sliderTagBlue		0
#define sliderTagGreen		1
#define sliderTagRed		2
#define sliderTagGray		9


@interface EditViewController : PhotoViewController {

	UISlider *ySlider_;
	UISlider *rSlider_;
	UISlider *gSlider_;
	UISlider *bSlider_;
	UIButton *resetButton_;
}

@property (nonatomic, retain) IBOutlet UISlider *ySlider;
@property (nonatomic, retain) IBOutlet UISlider *rSlider;
@property (nonatomic, retain) IBOutlet UISlider *gSlider;
@property (nonatomic, retain) IBOutlet UISlider *bSlider;
@property (nonatomic, retain) IBOutlet UIButton *resetButton;

@end
