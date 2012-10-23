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
 */
- (void)parseMarkdown
{
    if (![self.text length]) {
        return;
    }
    const char * prose = [self.text UTF8String];
    struct buf *ib, *ob;

    int length = [self.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding] + 1;

    ib = bufnew(length);
    bufgrow(ib, length);
    memcpy(ib->data, prose, length);
    ib->size = length;

    ob = bufnew(64);

    struct sd_callbacks callbacks;
    struct html_renderopt options;
    struct sd_markdown *markdown;

    sdhtml_renderer(&callbacks, &options, 0);
    markdown = sd_markdown_new(0, 16, &callbacks, &options);

    sd_markdown_render(ob, ib->data, ib->size, markdown);
    sd_markdown_free(markdown);

    NSString *shinyNewHTML = [NSString stringWithUTF8String:ob->data];
    [self.webView loadHTMLString:shinyNewHTML baseURL:[[NSURL alloc] initWithString:@""]];

    bufrelease(ib);
    bufrelease(ob);
}

@end
