//
//  NLWUnitViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 8/30/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWUnitViewController.h"
#import "NLWButton.h"
#import "Constants.h"
#import "Keys.h"
#import "NLWUnitDetailViewController.h"
#import <Parse/Parse.h>

@interface NLWUnitViewController ()

@property (nonatomic, strong) NSArray * unitInfo;
@property (nonatomic, strong) NSString * htmlToPass;
@property BOOL loaded;

@end

@implementation NLWUnitViewController

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
	[self pullUnitInfo];
	// Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
		
	CGRect screenDimensions = [UIScreen mainScreen].bounds;
	CGFloat heightOfNavBar = self.navigationController.navigationBar.frame.size.height;
	CGFloat heightOfStatusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
	screenDimensions.size.height-=heightOfNavBar;
	screenDimensions.size.height-=heightOfStatusBar;
	
	UIImageView * emblemImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NROTC-EMBLEM-l.png"]];
	emblemImageView.frame = CGRectMake(0,
																		 0,
																		 screenDimensions.size.width,
																		 screenDimensions.size.height / 2);
	emblemImageView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:emblemImageView];
	
	
	NLWButton *buttonCO = [NLWButton buttonWithType:UIButtonTypeCustom];
	buttonCO.frame = CGRectMake(0,
															screenDimensions.size.height / 2,
															screenDimensions.size.width,
															screenDimensions.size.height / 6);
	[buttonCO addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[buttonCO setTitle:@"Captain Michael Ryan, USN\nCommanding Officer" forState:UIControlStateNormal];
	buttonCO.titleLabel.textAlignment = NSTextAlignmentCenter;
//	buttonCO.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]*1.5];
	buttonCO.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//	[buttonCO setBackgroundImage:[UIImage imageNamed:@"declaration.png"] forState:UIControlStateNormal];
	buttonCO.unHighlightedColor = [UIColor colorWithRed:2.0/255 green:43.0/255 blue:91.0/255 alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	buttonCO.highlightedColor = [UIColor colorWithRed:2.0/255 + HIGHLIGHT_DARKNESS green:43.0/255 + HIGHLIGHT_DARKNESS blue:91.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:buttonCO];
	
	NLWButton *buttonXO = [NLWButton buttonWithType:UIButtonTypeCustom];
	buttonXO.frame = CGRectMake(0,
															screenDimensions.size.height * 4 / 6,
															screenDimensions.size.width,
															screenDimensions.size.height / 6);
	[buttonXO addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[buttonXO setTitle:@"Commander Frederick Landau, USN\nExecutive Officer" forState:UIControlStateNormal];
	buttonXO.titleLabel.textAlignment = NSTextAlignmentCenter;
//	buttonXO.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]*1.5];
	buttonXO.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	//	[buttonCO setBackgroundImage:[UIImage imageNamed:@"declaration.png"] forState:UIControlStateNormal];
	buttonXO.unHighlightedColor = [UIColor colorWithRed:2.0/255 + 0.5 * HIGHLIGHT_DARKNESS green:43.0/255 + 0.5 * HIGHLIGHT_DARKNESS blue:91.0/255 + HIGHLIGHT_DARKNESS * 0.5 alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	buttonXO.highlightedColor = [UIColor colorWithRed:2.0/255 + HIGHLIGHT_DARKNESS * 1.5 green:43.0/255 + HIGHLIGHT_DARKNESS * 1.5 blue:91.0/255 + HIGHLIGHT_DARKNESS * 1.5 alpha:1.0];
	[self.view addSubview:buttonXO];

	NLWButton *buttonMOI = [NLWButton buttonWithType:UIButtonTypeCustom];
	buttonMOI.frame = CGRectMake(0,
															 screenDimensions.size.height * 5 / 6,
															 screenDimensions.size.width,
															 screenDimensions.size.height / 6);
	[buttonMOI addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[buttonMOI setTitle:@"Major Jackie Schiller, USMC\nMarine Officer Instructor" forState:UIControlStateNormal];
	buttonMOI.titleLabel.textAlignment = NSTextAlignmentCenter;
	//	buttonXO.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]*1.5];
	buttonMOI.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	//	[buttonCO setBackgroundImage:[UIImage imageNamed:@"declaration.png"] forState:UIControlStateNormal];
	buttonMOI.unHighlightedColor = [UIColor colorWithRed:2.0/255 + HIGHLIGHT_DARKNESS green:43.0/255 + HIGHLIGHT_DARKNESS blue:91.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	buttonMOI.highlightedColor = [UIColor colorWithRed:2.0/255 + HIGHLIGHT_DARKNESS * 2 green:43.0/255 + HIGHLIGHT_DARKNESS * 2 blue:91.0/255 + HIGHLIGHT_DARKNESS * 2 alpha:1.0];
	[self.view addSubview:buttonMOI];

	[buttonCO setHighlighted:NO];
	[buttonXO setHighlighted:NO];
	[buttonMOI setHighlighted:NO];

}

-(void)pullUnitInfo
{
	UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	spinner.hidesWhenStopped = YES;
	spinner.center = self.view.center;
	[self.view addSubview:spinner];
	
	[spinner startAnimating];
	//turn on the network spinner
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	//build the query that will return the scheduled events
	PFQuery * queryForUnitInfo = [PFQuery queryWithClassName:PARSE_NDUNIT_CLASS];
	
	//execute the query in the background.
	[queryForUnitInfo findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
		if (!error) {//the query succeeded
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			
			NSMutableArray * tempUnitInfo = [[NSMutableArray alloc] init];
			
			for (PFObject * unitInfo in objects)
			{
				NSDictionary * unitInfoDict = @{PARSE_NDUNIT_NAME: [unitInfo objectForKey:PARSE_NDUNIT_NAME],PARSE_NDUNIT_DETAIL_HTML: [unitInfo objectForKey:PARSE_NDUNIT_DETAIL_HTML]};
				[tempUnitInfo addObject:unitInfoDict];
			}
			
			self.unitInfo = [tempUnitInfo copy];

			dispatch_async(dispatch_get_main_queue(), ^(void){
				[spinner stopAnimating];
			});
			self.loaded = YES;
			
		} else { //the query did not succeed.
			
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			[self.navigationController popViewControllerAnimated:YES];
			[[[UIAlertView alloc] initWithTitle:@"Unit Information Not Available"
																	message:@"Could not retrieve the the Notre Dame unit information. We apologize for the inconvenience."
																 delegate:self
												cancelButtonTitle:@"OK"
												otherButtonTitles: nil] show];
			
		}
	}];
}

-(void)buttonTapped:(UIButton *) button
{
	if (!self.loaded) return;
	
	if ([button.titleLabel.text isEqualToString:@"Captain Michael Ryan, USN\nCommanding Officer"])
	{
		for (NSDictionary * unitInfo in self.unitInfo)
		{
			if ([[unitInfo objectForKey:PARSE_NDUNIT_NAME] isEqualToString:@"CO"])
			{
				self.htmlToPass = [unitInfo objectForKey:PARSE_NDUNIT_DETAIL_HTML];
				[self performSegueWithIdentifier:@"unitDetail" sender:self];
			}
		}
	}
	else if([button.titleLabel.text isEqualToString:@"Commander Frederick Landau, USN\nExecutive Officer"])
	{
		for (NSDictionary * unitInfo in self.unitInfo)
		{
			if ([[unitInfo objectForKey:PARSE_NDUNIT_NAME] isEqualToString:@"XO"])
			{
				self.htmlToPass = [unitInfo objectForKey:PARSE_NDUNIT_DETAIL_HTML];
				[self performSegueWithIdentifier:@"unitDetail" sender:self];
			}
		}
	}
	else if([button.titleLabel.text isEqualToString:@"Major Jackie Schiller, USMC\nMarine Officer Instructor"])
	{
		for (NSDictionary * unitInfo in self.unitInfo)
		{
			if ([[unitInfo objectForKey:PARSE_NDUNIT_NAME] isEqualToString:@"MOI"])
			{
				self.htmlToPass = [unitInfo objectForKey:PARSE_NDUNIT_DETAIL_HTML];
				[self performSegueWithIdentifier:@"unitDetail" sender:self];
			}
		}
	}
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[super prepareForSegue:segue sender:sender];
	if ([segue.identifier isEqualToString:@"unitDetail"])
	{
		NLWUnitDetailViewController * destinationVC = [segue destinationViewController];
		destinationVC.html = self.htmlToPass;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
