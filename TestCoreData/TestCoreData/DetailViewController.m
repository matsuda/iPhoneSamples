//
//  DetailViewController.m
//  TestCoreData
//
//  Created by matsuda on 12/05/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize managedObjectContext;
@synthesize scrollView, nameField, zipCodeField, stateField, cityField, otherField;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.nameField.text = self.detailItem.name;
        self.zipCodeField.text = self.detailItem.address.zipCode;
        self.stateField.text = self.detailItem.address.state;
        self.cityField.text = self.detailItem.address.city;
        self.otherField.text = self.detailItem.address.other;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.scrollView.contentSize = CGSizeMake(320, 800);
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)done
{
    self.detailItem.name = nameField.text;
    self.detailItem.address.zipCode = zipCodeField.text;
    self.detailItem.address.state = stateField.text;
    self.detailItem.address.city = cityField.text;
    self.detailItem.address.other = otherField.text;

    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"error >>> %@, %@", error, [error userInfo]);
        abort();
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
