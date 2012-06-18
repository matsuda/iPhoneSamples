//
//  CustomTweetViewController.m
//  TestTwitter
//
//  Created by matsuda on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomTweetViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

static NSString * kTwitterUpdateURL = @"https://upload.twitter.com/1/statuses/update_with_media.json";

@interface CustomTweetViewController ()

@end

@implementation CustomTweetViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tweet:(id)sender
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];

    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        if (!granted) {
            return;
        }
        NSArray *accounts = [accountStore accountsWithAccountType:accountType];
        if ([accounts count] > 0) {
            ACAccount *account = [accounts objectAtIndex:0];
            NSURL *url = [NSURL URLWithString:kTwitterUpdateURL];
            TWRequest *postRequest = [[TWRequest alloc] initWithURL:url parameters:nil requestMethod:TWRequestMethodPOST];
            [postRequest setAccount:account];

            UIImage *image = [UIImage imageNamed:@"Octocat"];
            NSData *data = UIImagePNGRepresentation(image);
            [postRequest addMultiPartData:data withName:@"media[]" type:@"multipart/form-data"];

            NSString *status = @"test iOS5 twitter.framework";
            [postRequest addMultiPartData:[status dataUsingEncoding:NSUTF8StringEncoding] withName:@"status" type:@"multipart/form-data"];

            [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                NSDictionary *tweet = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
                NSLog(@"tweet >>> %@", tweet);
            }];
        }
    }];
}

@end
