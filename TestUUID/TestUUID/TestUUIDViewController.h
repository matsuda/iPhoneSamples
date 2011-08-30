//
//  TestUUIDViewController.h
//  TestUUID
//
//  Created by Kosuke Matsuda on 11/08/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestUUIDViewController : UIViewController {
    UILabel *uuid_;
	UIButton *loadButton_;
	UIButton *createButton_;
	UIButton *saveButton_;
	UIButton *clearButton_;
}

@property (nonatomic, retain) IBOutlet UILabel *uuid;
@property (nonatomic, retain) IBOutlet UIButton *loadButton;
@property (nonatomic, retain) IBOutlet UIButton *createButton;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) IBOutlet UIButton *clearButton;


- (IBAction)createUUID:(id)sender;
- (IBAction)loadUUID:(id)sender;
- (IBAction)saveUUID:(id)sender;
- (IBAction)clearUUID:(id)sender;

@end
