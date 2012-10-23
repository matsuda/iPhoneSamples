//
//  PreviewViewController.m
//  TestSundown
//
//  Created by Kosuke Matsuda on 2012/10/23.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import "PreviewViewController.h"
#import "markdown.h"
#import "html.h"

@interface PreviewViewController ()
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@end

@implementation PreviewViewController

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
    [self parseMarkdown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 http://stackoverflow.com/questions/1435288/what-is-the-simplest-implementation-of-markdown-for-a-cocoa-application/7862315#7862315
 http://cartera.me/2011/10/16/made-on-a-mac/
 */
- (void)parseMarkdown
{
    if (![self.text length]) return;

    // Create and fill a buffer for with the raw markdown data.
    const char *rawMarkdown = [self.text cStringUsingEncoding:NSUTF8StringEncoding];
    struct buf *inputBuffer = bufnew(strlen(rawMarkdown));
    bufputs(inputBuffer, rawMarkdown);

    struct sd_callbacks callbacks;
    struct html_renderopt options;
    struct sd_markdown *markdown;

    // Parse the markdown into a new buffer using Sundown.
    sdhtml_renderer(&callbacks, &options, 0);
    markdown = sd_markdown_new(0, 16, &callbacks, &options);

    struct buf *outputBuffer = bufnew(64);
    sd_markdown_render(outputBuffer, inputBuffer->data, inputBuffer->size, markdown);
    sd_markdown_free(markdown);

    NSString *shinyNewHTML = [NSString stringWithCString:bufcstr(outputBuffer) encoding:NSUTF8StringEncoding];
    [self.webView loadHTMLString:shinyNewHTML baseURL:[[NSURL alloc] initWithString:@""]];

    bufrelease(inputBuffer);
    bufrelease(outputBuffer);
}

- (IBAction)closePreivew:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
