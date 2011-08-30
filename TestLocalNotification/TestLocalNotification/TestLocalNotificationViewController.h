//
//  TestLocalNotificationViewController.h
//  TestLocalNotification
//
//  Created by Kosuke Matsuda on 11/08/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestLocalNotificationViewController : UIViewController {
    UILocalNotification *notification_;
    UIButton *registerButton_;
    UIButton *cancelButton_;
}

@property (nonatomic, retain) UILocalNotification *notification;
@property (nonatomic, retain) IBOutlet UIButton *registerButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;

- (IBAction)registerLocalNotification;
- (IBAction)cancelLocalNotification;

@end
