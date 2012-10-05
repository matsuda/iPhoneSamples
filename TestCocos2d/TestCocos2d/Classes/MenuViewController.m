//
//  MenuViewController.m
//  TestCocos2d
//
//  Created by matsuda on 2012/10/04.
//
//

#import "MenuViewController.h"

#import "cocos2d.h"
#import "TransitionLayer1.h"
#import "EffectLayer.h"

static NSString *transitions[] =
{
	@"CCTransitionJumpZoom",

	@"CCTransitionProgressRadialCCW",
	@"CCTransitionProgressRadialCW",
	@"CCTransitionProgressHorizontal",
	@"CCTransitionProgressVertical",
	@"CCTransitionProgressInOut",
	@"CCTransitionProgressOutIn",

	@"CCTransitionCrossFade",

	@"TransitionPageForward",
	@"TransitionPageBackward",

	@"CCTransitionFadeTR",
	@"CCTransitionFadeBL",
	@"CCTransitionFadeUp",
	@"CCTransitionFadeDown",

	@"CCTransitionTurnOffTiles",

	@"CCTransitionSplitRows",
	@"CCTransitionSplitCols",

	@"CCTransitionFade",
	@"FadeWhiteTransition",

	@"FlipXLeftOver",
	@"FlipXRightOver",
	@"FlipYUpOver",
	@"FlipYDownOver",
	@"FlipAngularLeftOver",
	@"FlipAngularRightOver",

	@"ZoomFlipXLeftOver",
	@"ZoomFlipXRightOver",
	@"ZoomFlipYUpOver",
	@"ZoomFlipYDownOver",
	@"ZoomFlipAngularLeftOver",
	@"ZoomFlipAngularRightOver",

	@"CCTransitionShrinkGrow",
	@"CCTransitionRotoZoom",

	@"CCTransitionMoveInL",
	@"CCTransitionMoveInR",
	@"CCTransitionMoveInT",
	@"CCTransitionMoveInB",

	@"CCTransitionSlideInL",
	@"CCTransitionSlideInR",
	@"CCTransitionSlideInT",
	@"CCTransitionSlideInB",
};

static const int transitions_size = sizeof(transitions) / sizeof(transitions[0]);

#pragma mark - Effects

static NSString *effects[] = {
    @"Particle"
};

static const int effects_size = sizeof(effects) / sizeof(effects[0]);


@interface MenuViewController () <UINavigationControllerDelegate> {
    NSInteger _selectedTransitionIndex;
}

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return transitions_size;
    } else {
        return effects_size;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Transitions";
    } else {
        return @"Effets";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    NSInteger idx = indexPath.row;
    if (indexPath.section == 0) {
        NSString *tr = transitions[idx];
        cell.textLabel.text = [NSString stringWithFormat:@"%d. %@", idx+1, tr];
    } else {
        NSString *tr = effects[idx];
        cell.textLabel.text = [NSString stringWithFormat:@"%d. %@", idx+1, tr];
    }

    // Configure the cell...
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
     [detailViewController release];
     */
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *scene;

    if (indexPath.section == 0) {
        _selectedTransitionIndex = indexPath.row;
        NSString *tr = transitions[_selectedTransitionIndex];
        scene = [TransitionLayer1 scene];

        TransitionLayer1 *layer = [scene.children objectAtIndex:0];
        layer.transitionName = tr;
    } else {
        scene = [EffectLayer scene];
    }
    [director pushScene:scene];
    [self.navigationController pushViewController:director animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }
    if ([viewController isKindOfClass:[CCDirector class]]) {
        NSString *tr = transitions[_selectedTransitionIndex];
        viewController.navigationItem.title = tr;
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end
