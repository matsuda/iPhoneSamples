//
//  TestThree20ViewController.h
//  TestThree20
//
//  Created by Kosuke Matsuda on 11/08/31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Three20/Three20.h>

@interface TestThree20ViewController : UIViewController {
    UIButton *button_;
}

@property (nonatomic, retain) IBOutlet UIButton *button;

- (IBAction)didTapButton:(id)sender;

@end
