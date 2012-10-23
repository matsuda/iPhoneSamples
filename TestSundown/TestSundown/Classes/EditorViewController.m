//
//  EditorViewController.m
//  TestSundown
//
//  Created by Kosuke Matsuda on 2012/10/23.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "EditorViewController.h"
#import "PreviewViewController.h"

@interface EditorViewController () <UITextViewDelegate>
@property (nonatomic, weak) IBOutlet UITextView *textView;
@end

@implementation EditorViewController

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
    [self loadText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadText
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"md"];
    NSError *error = nil;
    self.textView.text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"previewSegue"]) {
        // PreviewViewController *controller = segue.destinationViewController;
        UINavigationController *naviController = segue.destinationViewController;
        PreviewViewController *controller = [naviController.viewControllers lastObject];
        controller.text = self.textView.text;
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
}

@end
