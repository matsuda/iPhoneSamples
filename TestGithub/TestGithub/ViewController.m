//
//  ViewController.m
//  TestGithub
//
//  Created by matsuda on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "UAGithubEngine.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextView *content;
@end

@implementation ViewController

@synthesize username = _username;
@synthesize password = _password;
@synthesize content = _content;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.username.text = @"matsuda";
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

- (IBAction)submit:(id)sender
{
    [self.view endEditing:YES];
    NSString *username = self.username.text;
    NSString *password = self.password.text;

    if ( !([self.username.text length] && [self.password.text length]) ) {
        return;
    }
    UAGithubEngine *engine = [[UAGithubEngine alloc] initWithUsername:username password:password withReachability:YES];

//    [engine gistsWithSuccess:^(id obj) {
//        NSLog(@"%@", obj);
//    } failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];

    [engine gist:@"2722993" success:^(id obj) {
        NSDictionary *gist = [(NSArray *)obj objectAtIndex:0];
        NSDictionary *files = [gist objectForKey:@"files"];
        NSArray *keys = [files allKeys];
        for (NSString *file in keys) {
            NSString *content = [[files objectForKey:file] objectForKey:@"content"];
            self.content.text = content;
            break;
        }
        NSLog(@"%@", gist);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
