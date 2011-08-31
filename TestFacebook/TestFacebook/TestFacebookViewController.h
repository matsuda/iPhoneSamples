//
//  TestFacebookViewController.h
//  TestFacebook
//
//  Created by Kosuke Matsuda on 11/08/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBConnect.h"

@interface TestFacebookViewController : UIViewController <FBSessionDelegate, FBDialogDelegate> {
    Facebook *facebook_;
    NSArray *permissions_;

    UIButton *loginButton_;
    UIButton *logoutButton_;
}

@property (readonly) Facebook *facebook;
@property (nonatomic, retain) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) IBOutlet UIButton *logoutButton;

- (IBAction)didTapButtonToLogin:(id)sender;
- (IBAction)didTapButtonToLogout:(id)sender;

@end
