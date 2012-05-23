//
//  DetailViewController.m
//  TestMagicalRecord
//
//  Created by matsuda on 12/05/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "Person.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize delegate;
@synthesize nameField;
@synthesize ageField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)savePersion:(id)sender
{
    if (nameField.text.length > 0 && ageField.text.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", nameField.text];
        NSNumber *resultNumber = [Person numberOfEntitiesWithPredicate:predicate];
        if ([resultNumber intValue] > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Name already exists" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        } else {
            Person *person = [Person createEntity];
            person.name = nameField.text;
            person.age = [NSNumber numberWithInt:[ageField.text intValue]];

            [[NSManagedObjectContext defaultContext] save];
            if ([self.delegate respondsToSelector:@selector(detailViewController:didSaveNewPersion:)]) {
                [self.delegate detailViewController:self didSaveNewPersion:person];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Fill out all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
