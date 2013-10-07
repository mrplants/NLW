//
//  NLWScheduleTableViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 8/26/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWScheduleTableViewController.h"
#import "NLWScheduleDetailViewController.h"
#import <Parse/Parse.h>
#import "Keys.h"

@interface NLWScheduleTableViewController ()

@property (nonatomic, strong) NSArray * events;
@property (nonatomic, strong) NSArray * sectionTitles;

@end

@implementation NLWScheduleTableViewController

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
	
	//pull the events from the online parse database
	[self pullSpeakers];
	
	[self.tableView reloadData];
	
	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)pullSpeakers
{
	//turn on the network spinner
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	//build the query that will return the scheduled events
	PFQuery * queryForToppings = [PFQuery queryWithClassName:PARSE_SCHEDULE_CLASS];
	
	//execute the query in the background.
	[queryForToppings findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
		if (!error) {//the query succeeded
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			
			NSMutableArray * tempEvents = [[NSMutableArray alloc] init];
			NSMutableArray * tempSectionTitles = [[NSMutableArray alloc] init];
			
			NSMutableArray * sortedObjects = [objects mutableCopy];
			NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:PARSE_SCHEDULE_DATE ascending: YES];
			[sortedObjects sortUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];
			
			for (PFObject* event in sortedObjects)
			{
				
				NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[event objectForKey:PARSE_SCHEDULE_DATE]];
				
				NSString * day;
				switch ([dateComponents weekday])
				{
					case 1:
						day = @"Sunday";
						break;
					case 2:
						day = @"Monday";
						break;
					case 3:
						day = @"Tuesday";
						break;
					case 4:
						day = @"Wednesday";
						break;
					case 5:
						day = @"Thursday";
						break;
					case 6:
						day = @"Friday";
						break;
					case 7:
						day = @"Saturday";
						break;
						
					default:
						break;
				}
				
				NSString * month;
				
				switch ([dateComponents month])
				{
					case 1:
						month = @"JAN";
						break;
					case 2:
						month = @"FEB";
						break;
					case 3:
						month = @"MAR";
						break;
					case 4:
						month = @"APR";
						break;
					case 5:
						month = @"MAY";
						break;
					case 6:
						month = @"JUN";
						break;
					case 7:
						month = @"JUL";
						break;
					case 8:
						month = @"AUG";
						break;
					case 9:
						month = @"SEP";
						break;
					case 10:
						month = @"OCT";
						break;
					case 11:
						month = @"NOV";
						break;
					case 12:
						month = @"DEC";
						break;
						
					default:
						break;
				}
				
				NSString * dayOfMonth = ([dateComponents day] < 10) ? [NSString stringWithFormat:@"0%d", [dateComponents day]] : [NSString stringWithFormat:@"%d", [dateComponents day]];
				
				NSString * tempTitle = [day stringByAppendingFormat:@", %@%@%d", dayOfMonth, month, [dateComponents year]];
				
				BOOL titleAlreadyUsed = NO;
				for (NSString * title in tempSectionTitles)
				{
					if ([title isEqualToString:tempTitle])
					{
						titleAlreadyUsed = YES;
					}
				}
				
				if (!titleAlreadyUsed)
				{
					[tempSectionTitles addObject:tempTitle];
				}
				
				NSDictionary * eventToAdd = @{PARSE_SCHEDULE_NAME: [event objectForKey:PARSE_SCHEDULE_NAME],
														 PARSE_SCHEDULE_DESCRIPTION_HTML: [event objectForKey:PARSE_SCHEDULE_DESCRIPTION_HTML],
														 PARSE_SCHEDULE_DATE: [event objectForKey:PARSE_SCHEDULE_DATE],
														 @"sectionTitle": tempTitle};
				
				[tempEvents addObject:eventToAdd];
				
				self.events = [tempEvents copy];
				self.sectionTitles = [tempSectionTitles copy];
				
				dispatch_async(dispatch_get_main_queue(), ^(void){
					[self.tableView reloadData];
				});

			}
						
		} else { //the query did not succeed.
			
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			[self.navigationController popViewControllerAnimated:YES];
			[[[UIAlertView alloc] initWithTitle:@"Speakers Not Available"
																	message:@"Could not retrieve the current list of speakers. We apologize for the inconvenience."
																 delegate:self
												cancelButtonTitle:@"OK"
												otherButtonTitles: nil] show];
			
		}
	}];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return self.sectionTitles[section];
	
	switch (section)
	{
		case 0://Friday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Friday"].location != NSNotFound)
				{
					return sectionTitle;
				}
			}
			break;
		case 1://Saturday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Saturday"].location != NSNotFound)
				{
					return sectionTitle;
				}
			}
			break;
		case 2://Sunday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Sunday"].location != NSNotFound)
				{
					return sectionTitle;
				}
			}
			break;
		case 3://Monday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Sunday"].location != NSNotFound)
				{
					return sectionTitle;
				}
			}
			break;
		case 4://Tuesday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Sunday"].location != NSNotFound)
				{
					return sectionTitle;
				}
			}
			break;
		case 5://Wednesday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Sunday"].location != NSNotFound)
				{
					return sectionTitle;
				}
			}
			break;
		case 6://Thursday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Sunday"].location != NSNotFound)
				{
					return sectionTitle;
				}
			}
			break;
			
		default:
			break;
	}
	return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return [self.sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSString * sectionTitle;
	NSString * sectionName;
	
//	switch (section)
//	{
//		case 0://Friday
//			for (NSString * sectionTitle in self.sectionTitles)
//			{
//				if ([sectionTitle rangeOfString:@"Friday"].location != NSNotFound)
//				{
//					sectionName = sectionTitle;
//				}
//			}
//			break;
//		case 1://Saturday
//			for (NSString * sectionTitle in self.sectionTitles)
//			{
//				if ([sectionTitle rangeOfString:@"Saturday"].location != NSNotFound)
//				{
//					sectionName = sectionTitle;
//				}
//			}
//			break;
//		case 2://Sunday
//			for (NSString * sectionTitle in self.sectionTitles)
//			{
//				if ([sectionTitle rangeOfString:@"Sunday"].location != NSNotFound)
//				{
//					sectionName = sectionTitle;
//				}
//			}
//			break;
//		case 3://Sunday
//			for (NSString * sectionTitle in self.sectionTitles)
//			{
//				if ([sectionTitle rangeOfString:@"Monday"].location != NSNotFound)
//				{
//					sectionName = sectionTitle;
//				}
//			}
//			break;
//		case 4://Sunday
//			for (NSString * sectionTitle in self.sectionTitles)
//			{
//				if ([sectionTitle rangeOfString:@"Tuesday"].location != NSNotFound)
//				{
//					sectionName = sectionTitle;
//				}
//			}
//			break;
//		case 5://Sunday
//			for (NSString * sectionTitle in self.sectionTitles)
//			{
//				if ([sectionTitle rangeOfString:@"Wednesday"].location != NSNotFound)
//				{
//					sectionName = sectionTitle;
//				}
//			}
//			break;
//		case 6://Sunday
//			for (NSString * sectionTitle in self.sectionTitles)
//			{
//				if ([sectionTitle rangeOfString:@"Thursday"].location != NSNotFound)
//				{
//					sectionName = sectionTitle;
//				}
//			}
//			break;
//			
//		default:
//			break;
//	}
	
	sectionName = self.sectionTitles[section];
	
	NSMutableArray * events = [[NSMutableArray alloc] init];
	
	for (NSDictionary * event in self.events)
	{
		if ([event[@"sectionTitle"] isEqualToString:sectionName])
		{
			[events addObject:event];
		}
	}
	return [events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Event Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  //create a temporary array of events based on the current section
	
	NSString * section;
	
	switch (indexPath.section)
	{
		case 0://Friday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Friday"].location != NSNotFound)
				{
					section = sectionTitle;
				}
			}
			break;
		case 1://Saturday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Saturday"].location != NSNotFound)
				{
					section = sectionTitle;
				}
			}
			break;
		case 2://Sunday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Sunday"].location != NSNotFound)
				{
					section = sectionTitle;
				}
			}
			break;
		case 3://Sunday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Monday"].location != NSNotFound)
				{
					section = sectionTitle;
				}
			}
			break;
		case 4://Sunday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Tuesday"].location != NSNotFound)
				{
					section = sectionTitle;
				}
			}
			break;
		case 5://Sunday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Wednesday"].location != NSNotFound)
				{
					section = sectionTitle;
				}
			}
			break;
		case 6://Sunday
			for (NSString * sectionTitle in self.sectionTitles)
			{
				if ([sectionTitle rangeOfString:@"Thursday"].location != NSNotFound)
				{
					section = sectionTitle;
				}
			}
			break;
			
		default:
			break;
	}
	
	section = self.sectionTitles[indexPath.section];
	
	NSMutableArray * events = [[NSMutableArray alloc] init];
	
	for (NSDictionary * event in self.events)
	{
		if ([event[@"sectionTitle"] isEqualToString:section])
		{
			[events addObject:event];
		}
	}
	
	cell.textLabel.text = events[indexPath.row][PARSE_SCHEDULE_NAME];
	
	return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[super prepareForSegue:segue sender:sender];
	if ([segue.identifier isEqualToString:@"Event Detail"])
	{
		NLWScheduleDetailViewController * destinationVC = segue.destinationViewController;
		
		NSIndexPath *indexOfSelectedRow = [self.tableView indexPathForSelectedRow];
		
		NSString * sectionTitle;
		NSString * sectionName;
		
//		switch (indexOfSelectedRow.section)
//		{
//			case 0://Friday
//				for (NSString * sectionTitle in self.sectionTitles)
//				{
//					if ([sectionTitle rangeOfString:@"Friday"].location != NSNotFound)
//					{
//						sectionName = sectionTitle;
//					}
//				}
//				break;
//			case 1://Saturday
//				for (NSString * sectionTitle in self.sectionTitles)
//				{
//					if ([sectionTitle rangeOfString:@"Saturday"].location != NSNotFound)
//					{
//						sectionName = sectionTitle;
//					}
//				}
//				break;
//			case 2://Sunday
//				for (NSString * sectionTitle in self.sectionTitles)
//				{
//					if ([sectionTitle rangeOfString:@"Sunday"].location != NSNotFound)
//					{
//						sectionName = sectionTitle;
//					}
//				}
//				break;
//			case 3://Monday
//				for (NSString * sectionTitle in self.sectionTitles)
//				{
//					if ([sectionTitle rangeOfString:@"Monday"].location != NSNotFound)
//					{
//						sectionName = sectionTitle;
//					}
//				}
//				break;
//			case 4://Tuesday
//				for (NSString * sectionTitle in self.sectionTitles)
//				{
//					if ([sectionTitle rangeOfString:@"Tuesday"].location != NSNotFound)
//					{
//						sectionName = sectionTitle;
//					}
//				}
//				break;
//			case 5://Wednesday
//				for (NSString * sectionTitle in self.sectionTitles)
//				{
//					if ([sectionTitle rangeOfString:@"Wednesday"].location != NSNotFound)
//					{
//						sectionName = sectionTitle;
//					}
//				}
//				break;
//			case 6://Thursday
//				for (NSString * sectionTitle in self.sectionTitles)
//				{
//					if ([sectionTitle rangeOfString:@"Thursday"].location != NSNotFound)
//					{
//						sectionName = sectionTitle;
//					}
//				}
//				break;
//				
//			default:
//				break;
//		}
		
		sectionName = self.sectionTitles[indexOfSelectedRow.section];
		
		NSMutableArray * events = [[NSMutableArray alloc] init];
		
		for (NSDictionary * event in self.events)
		{
			if ([event[@"sectionTitle"] isEqualToString:sectionName])
			{
				[events addObject:event];
			}
		}
		
		destinationVC.navigationItem.title = events[indexOfSelectedRow.row][PARSE_SCHEDULE_NAME];
		destinationVC.description = events[indexOfSelectedRow.row][PARSE_SCHEDULE_DESCRIPTION_HTML];
	}
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Navigation logic may go here. Create and push another view controller.
	[self performSegueWithIdentifier:@"Event Detail" sender:self];
  
}

@end
