//
//  NLWAttractionsTableViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 9/8/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWAttractionsTableViewController.h"
#import "NLWAttractionsDetailViewController.h"
#import <Parse/Parse.h>
#import "Keys.h"

@interface NLWAttractionsTableViewController ()

@property (nonatomic, strong) NSArray * attractions;

@end

@implementation NLWAttractionsTableViewController

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
	[self pullSpeakers];

	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationZItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)pullSpeakers
{
	//turn on the network spinner
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	//build the query that will return the scheduled events
	PFQuery * queryForToppings = [PFQuery queryWithClassName:PARSE_ATTRACTIONS_CLASS];
	
	//execute the query in the background.
	[queryForToppings findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
		if (!error) {//the query succeeded
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			
			NSMutableArray * tempAttractions = [[NSMutableArray alloc] init];
			
			for (PFObject * policy in objects)
			{
				NSDictionary * policyDict = @{PARSE_ATTRACTIONS_HEADER: [policy objectForKey:PARSE_ATTRACTIONS_HEADER],PARSE_ATTRACTIONS_DESCRIPTION_HTML: [policy objectForKey:PARSE_ATTRACTIONS_DESCRIPTION_HTML]};
				[tempAttractions addObject:policyDict];
			}
			
			self.attractions = [tempAttractions copy];
			
			[self.tableView reloadData];
		} else { //the query did not succeed.
			
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			[self.navigationController popViewControllerAnimated:YES];
			[[[UIAlertView alloc] initWithTitle:@"Attractions Not Available"
																	message:@"Could not retrieve the list of Attractions. We apologize for the inconvenience."
																 delegate:self
												cancelButtonTitle:@"OK"
												otherButtonTitles: nil] show];
			
		}
	}];
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
	return [self.attractions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Attractions Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	cell.textLabel.text = self.attractions[indexPath.row][PARSE_ATTRACTIONS_HEADER];
	
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
	[self performSegueWithIdentifier:@"Attractions Detail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[super prepareForSegue:segue sender:sender];
	if ([segue.identifier isEqualToString:@"Attractions Detail"])
	{
		NLWAttractionsDetailViewController * destinationVC = segue.destinationViewController;
		destinationVC.html = self.attractions[[self.tableView indexPathForSelectedRow].row][PARSE_ATTRACTIONS_DESCRIPTION_HTML];
		destinationVC.header = self.attractions[[self.tableView indexPathForSelectedRow].row][PARSE_ATTRACTIONS_HEADER];
	}
}

@end
