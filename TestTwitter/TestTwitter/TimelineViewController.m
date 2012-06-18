//
//  TimelineViewController.m
//  TestTwitter
//
//  Created by matsuda on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TimelineViewController.h"
#import <Twitter/Twitter.h>

//static NSString * kTimelineURL = @"http://api.twitter.com/1/statuses/public_timeline.json";
static NSString * kTimelineURL = @"http://api.twitter.com/1/statuses/user_timeline.json";

@interface TimelineViewController ()
@property (strong, nonatomic) NSMutableArray *timelines;
@end

@implementation TimelineViewController

@synthesize timelines = _timelines;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.timelines = [NSMutableArray array];
    [self getPublicTimelines];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_timelines count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimelineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.textLabel.text = [_timelines objectAtIndex:indexPath.row];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)getPublicTimelines
{
    NSLog(@"aaaaaaaaaaaaaaaaaa");
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"mtd" forKey:@"screen_name"];
    [params setObject:@"5" forKey:@"count"];
    [params setObject:@"1" forKey:@"include_entities"];
    [params setObject:@"1" forKey:@"include_rts"];

    TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:kTimelineURL] parameters:params requestMethod:TWRequestMethodGET];

    [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSArray *timeline = nil;
        if ([urlResponse statusCode] == 200) {
            NSError *jsonParsingError = nil;
            timeline = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&jsonParsingError];
            NSLog(@"%@", timeline);
            NSLog(@"%d", [timeline count]);
        } else {
            NSLog(@"status code >>> %i", [urlResponse statusCode]);
        }
        [self performSelectorOnMainThread:@selector(displayTimeline:) withObject:timeline waitUntilDone:NO];
    }];
}

- (void)displayTimeline:(NSArray *)timeline
{
    NSLog(@"bbbbbbbbbbbbbbbbbbbb");
    for (NSDictionary *tweet in timeline) {
        [_timelines addObject:[tweet objectForKey:@"text"]];
    }
    NSLog(@"timelines >>> %@", _timelines);
    [self.tableView reloadData];
}

@end
