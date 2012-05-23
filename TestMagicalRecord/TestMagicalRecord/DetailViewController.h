//
//  DetailViewController.h
//  TestMagicalRecord
//
//  Created by matsuda on 12/05/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;
@protocol DetailViewControllerDelegate;

@interface DetailViewController : UIViewController

@property (weak, nonatomic) id<DetailViewControllerDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *ageField;

- (IBAction)savePersion:(id)sender;

@end

@protocol DetailViewControllerDelegate <NSObject>
@optional
- (void)detailViewController:(DetailViewController *)controller didSaveNewPersion:(Person *)person;
@end
