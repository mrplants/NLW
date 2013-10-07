////
////  NLWActivitiesTableViewController.m
////  NLW
////
////  Created by Sean Fitzgerald on 8/26/13.
////  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
////
//
//#import "NLWActivitiesTableViewController.h"
//#import "NLWActivitiesDetailViewController.h"
//#import "Keys.h"
//#import <Parse/Parse.h>
//
//@interface NLWActivitiesTableViewController ()
//
//@property (nonatomic, strong) NSArray * activities;
//
//@end
//
//@implementation NLWActivitiesTableViewController
//
//- (id)initWithStyle:(UITableViewStyle)style
//{
//	self = [super initWithStyle:style];
//	if (self) {
//		// Custom initialization
//	}
//	return self;
//}
//
//- (void)viewDidLoad
//{
//	[super viewDidLoad];
//	
//	[self pullActivities];
//	
////	self.activities = @[@{@"name" : @"Basketball",
////											 @"description" : @"Basketball description goes here"},
////										 @{@"name" : @"Cookout",
////						 @"description" : @"cookout description goes here"},
////										 @{@"name" : @"Event 1",
////						 @"description" : @"Event 1 description"},
////										 @{@"name" : @"Event 2",
////						 @"description" : @"Event 2 description"}];
//	
//	// Uncomment the following line to preserve selection between presentations.
//	// self.clearsSelectionOnViewWillAppear = NO;
//	
//	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}
//
//-(void)pullActivities
//{
//	//turn on the network spinner
//	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//	
//	//build the query that will return the scheduled events
//	PFQuery * queryForToppings = [PFQuery queryWithClassName:];
//	
//	//execute the query in the background.
//	[queryForToppings findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
//		if (!error) {//the query succeeded
//			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
//			
//			NSMutableArray * tempEvents = [[NSMutableArray alloc] init];
//			NSMutableArray * tempSectionTitles = [[NSMutableArray alloc] init];
//			for (PFObject* event in objects)
//			{
//				
//				NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[event objectForKey:PARSE_SCHEDULE_DATE]];
//				
//				NSString * day;
//				switch ([dateComponents weekday])
//				{
//					case 1:
//						day = @"Sunday";
//						break;
//					case 2:
//						day = @"Monday";
//						break;
//					case 3:
//						day = @"Tuesday";
//						break;
//					case 4:
//						day = @"Wednesday";
//						break;
//					case 5:
//						day = @"Thursday";
//						break;
//					case 6:
//						day = @"Friday";
//						break;
//					case 7:
//						day = @"Saturday";
//						break;
//						
//					default:
//						break;
//				}
//				
//				NSString * month;
//				
//				switch ([dateComponents month])
//				{
//					case 1:
//						month = @"JAN";
//						break;
//					case 2:
//						month = @"FEB";
//						break;
//					case 3:
//						month = @"MAR";
//						break;
//					case 4:
//						month = @"APR";
//						break;
//					case 5:
//						month = @"MAY";
//						break;
//					case 6:
//						month = @"JUN";
//						break;
//					case 7:
//						month = @"JUL";
//						break;
//					case 8:
//						month = @"AUG";
//						break;
//					case 9:
//						month = @"SEP";
//						break;
//					case 10:
//						month = @"OCT";
//						break;
//					case 11:
//						month = @"NOV";
//						break;
//					case 12:
//						month = @"DEC";
//						break;
//						
//					default:
//						break;
//				}
//				
//				NSString * dayOfMonth = ([dateComponents day] < 10) ? [NSString stringWithFormat:@"0%d", [dateComponents day]] : [NSString stringWithFormat:@"%d", [dateComponents day]];
//				
//				NSString * tempTitle = [day stringByAppendingFormat:@", %@%@%d", dayOfMonth, month, [dateComponents year]];
//				
//				BOOL titleAlreadyUsed = NO;
//				for (NSString * title in tempSectionTitles)
//				{
//					if ([title isEqualToString:tempTitle])
//					{
//						titleAlreadyUsed = YES;
//					}
//				}
//				
//				if (!titleAlreadyUsed)
//				{
//					[tempSectionTitles addObject:tempTitle];
//				}
//				
//				NSDictionary * eventToAdd = @{PARSE_SCHEDULE_NAME: [event objectForKey:PARSE_SCHEDULE_NAME],
//																	PARSE_SCHEDULE_DESCRIPTION_HTML: [event objectForKey:PARSE_SCHEDULE_DESCRIPTION_HTML],
//																	PARSE_SCHEDULE_DATE: [event objectForKey:PARSE_SCHEDULE_DATE],
//																	@"sectionTitle": tempTitle};
//				
//				[tempEvents addObject:eventToAdd];
//				
//				self.events = [tempEvents copy];
//				self.sectionTitles = [tempSectionTitles copy];
//				
//				[self.tableView reloadData];
//			}
//			
//		} else { //the query did not succeed.
//			
//			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
//			[[[UIAlertView alloc] initWithTitle:@"Speakers Not Available"
//																	message:@"Could not retrieve the current list of speakers. We apologize for the inconvenience."
//																 delegate:self
//												cancelButtonTitle:@"OK"
//												otherButtonTitles: nil] show];
//			
//		}
//	}];
//}
//
//- (void)didReceiveMemoryWarning
//{
//	[super didReceiveMemoryWarning];
//	// Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//	// Return the number of sections.
//	return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//	// Return the number of rows in the section.
//	return [self.activities count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	static NSString *CellIdentifier = @"Activities Cell";
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//  
//	cell.textLabel.text = self.activities[indexPath.row][@"name"];
//	
//	// Configure the cell...
//	
//	return cell;
//}
//
///*
// // Override to support conditional editing of the table view.
// - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
// {
// // Return NO if you do not want the specified item to be editable.
// return YES;
// }
// */
//
///*
// // Override to support editing the table view.
// - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
// {
// if (editingStyle == UITableViewCellEditingStyleDelete) {
// // Delete the row from the data source
// [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
// }
// else if (editingStyle == UITableViewCellEditingStyleInsert) {
// // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
// }
// }
// */
//
///*
// // Override to support rearranging the table view.
// - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
// {
// }
// */
//
///*
// // Override to support conditional rearranging of the table view.
// - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
// {
// // Return NO if you do not want the item to be re-orderable.
// return YES;
// }
// */
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//	[super prepareForSegue:segue sender:sender];
//	if ([segue.identifier isEqualToString:@"Activities Detail"])
//	{
//		NLWActivitiesDetailViewController * destinationVC = segue.destinationViewController;
//		
//		int indexOfSelectedRow = [self.tableView indexPathForSelectedRow].row;
//		destinationVC.navigationItem.title = self.activities[indexOfSelectedRow][@"name"];
//		destinationVC.description = self.activities[indexOfSelectedRow][@"description"];
//	}
//}
//
//#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	// Navigation logic may go here. Create and push another view controller.
//	[self performSegueWithIdentifier:@"Activities Detail" sender:self];
//  
//}
//
//@end
