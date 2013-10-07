//
//  NLWViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 8/26/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWViewController.h"
#import "NLWButton.h"
#import "Constants.h"

#define TITLE YES
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface NLWViewController ()

@end

@implementation NLWViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidLayoutSubviews
{
	//tall view is w=160, h=168
	//short view is w = 160, h = 139
	
	
	[super viewDidLayoutSubviews];
	
	CGRect screenDimensions = [UIScreen mainScreen].bounds;
		
	CGFloat heightOfNavBar = self.navigationController.navigationBar.frame.size.height;
	CGFloat heightOfStatusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
	screenDimensions.size.height-=heightOfNavBar;
	screenDimensions.size.height-=heightOfStatusBar;
	
	NSLog(@"button dimensions: %f, %f", screenDimensions.size.width / 2, screenDimensions.size.height / 3);
	
	NLWButton *mapButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	mapButton.frame = CGRectMake(0,
															 0,
															 screenDimensions.size.width / 2,
															 screenDimensions.size.height / 3);
	[mapButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	if(TITLE)[mapButton setTitle:@"MAP" forState:UIControlStateNormal];
	[mapButton setTitleEdgeInsets:UIEdgeInsetsMake(mapButton.frame.size.height * 10 / 12,
																								 0,
																								 mapButton.frame.size.height / 12,
																								 0)];
	mapButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize] * 1.5];
	[mapButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
	if(!IS_IPHONE_5)[mapButton setBackgroundImage:[UIImage imageNamed:@"map_icon.png"] forState:UIControlStateNormal];
	else [mapButton setBackgroundImage:[UIImage imageNamed:@"map_icon@2x_tall.png"] forState:UIControlStateNormal];
	mapButton.unHighlightedColor = [UIColor colorWithRed:2.0/255 green:43.0/255 blue:91.0/255 alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	mapButton.highlightedColor = [UIColor colorWithRed:2.0/255 + HIGHLIGHT_DARKNESS green:43.0/255 + HIGHLIGHT_DARKNESS blue:91.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:mapButton];

	NLWButton *scheduleButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	scheduleButton.frame = CGRectMake(screenDimensions.size.width / 2,
																		0,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 3);
	[scheduleButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	if(TITLE)[scheduleButton setTitle:@"SCHEDULE" forState:UIControlStateNormal];
	[scheduleButton setTitleEdgeInsets:UIEdgeInsetsMake(mapButton.frame.size.height * 10 / 12,
																								 0,
																								 mapButton.frame.size.height / 12,
																								 0)];
	scheduleButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize] * 1.5];
	[scheduleButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
	if(!IS_IPHONE_5)[scheduleButton setBackgroundImage:[UIImage imageNamed:@"clock_icon.png"] forState:UIControlStateNormal];
	else [scheduleButton setBackgroundImage:[UIImage imageNamed:@"clock_icon@2x_tall.png"] forState:UIControlStateNormal];
	scheduleButton.unHighlightedColor = [UIColor colorWithRed:220.0/255 green:180.0/255 blue:57.0/255 alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	scheduleButton.highlightedColor = [UIColor colorWithRed:220.0/255 + HIGHLIGHT_DARKNESS green:180.0/255 + HIGHLIGHT_DARKNESS blue:57.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:scheduleButton];
	
	NLWButton *activitiesButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	activitiesButton.frame = CGRectMake(0,
																			screenDimensions.size.height / 3,
																			screenDimensions.size.width / 2,
																			screenDimensions.size.height / 3);
	[activitiesButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	if(TITLE)[activitiesButton setTitle:@"SPEAKERS" forState:UIControlStateNormal];
	[activitiesButton setTitleEdgeInsets:UIEdgeInsetsMake(mapButton.frame.size.height * 10 / 12,
																								 0,
																								 mapButton.frame.size.height / 12,
																								 0)];
	if(!IS_IPHONE_5)[activitiesButton setBackgroundImage:[UIImage imageNamed:@"speaker_icon.png"] forState:UIControlStateNormal];
	else [activitiesButton setBackgroundImage:[UIImage imageNamed:@"speaker_icon@2x_tall.png"] forState:UIControlStateNormal];
	activitiesButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize] * 1.5];
	[activitiesButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
	activitiesButton.unHighlightedColor = [UIColor colorWithRed:2.0/255 + 0.5*HIGHLIGHT_DARKNESS green:43.0/255+0.5*HIGHLIGHT_DARKNESS blue:91.0/255+0.5*HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	activitiesButton.highlightedColor = [UIColor colorWithRed:2.0/255 + 1.5*HIGHLIGHT_DARKNESS green:43.0/255 + 1.5*HIGHLIGHT_DARKNESS blue:91.0/255 + 1.5*HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:activitiesButton];
	
	NLWButton *speakersButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	speakersButton.frame = CGRectMake(screenDimensions.size.width / 2,
																		screenDimensions.size.height / 3,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 3);
	[speakersButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	if(TITLE)[speakersButton setTitle:@"CONTACTS" forState:UIControlStateNormal];
	[speakersButton setTitleEdgeInsets:UIEdgeInsetsMake(mapButton.frame.size.height * 10 / 12,
																								 0,
																								 mapButton.frame.size.height / 12,
																								 0)];
	speakersButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize] * 1.5];
	[speakersButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
	[speakersButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	if(!IS_IPHONE_5)[speakersButton setBackgroundImage:[UIImage imageNamed:@"phone_icon.png"] forState:UIControlStateNormal];
	else [speakersButton setBackgroundImage:[UIImage imageNamed:@"phone_icon@2x_tall.png"] forState:UIControlStateNormal];
	speakersButton.unHighlightedColor = [UIColor colorWithRed:220.0/255 + 0.5 *HIGHLIGHT_DARKNESS green:180.0/255 + 0.5*HIGHLIGHT_DARKNESS blue:57.0/255 + 0.5*HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	speakersButton.highlightedColor = [UIColor colorWithRed:220.0/255 + 1.5*HIGHLIGHT_DARKNESS green:180.0/255 + 1.5*HIGHLIGHT_DARKNESS blue:57.0/255 + 1.5*HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:speakersButton];
	
	NLWButton *policiesButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	policiesButton.frame = CGRectMake(0,
																		screenDimensions.size.height * 2 / 3,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 3);
	[policiesButton addTarget:self action:@selector(informationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
	if(TITLE)[policiesButton setTitle:@"GENERAL" forState:UIControlStateNormal];
	[policiesButton setTitleEdgeInsets:UIEdgeInsetsMake(mapButton.frame.size.height * 10 / 12,
																								 0,
																								 mapButton.frame.size.height / 12,
																								 0)];
	policiesButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize] * 1.5];
	[policiesButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
	if(!IS_IPHONE_5)[policiesButton setBackgroundImage:[UIImage imageNamed:@"uncertain.png"] forState:UIControlStateNormal];
	else [policiesButton setBackgroundImage:[UIImage imageNamed:@"uncertain@2x_tall.png"] forState:UIControlStateNormal];
	policiesButton.unHighlightedColor = [UIColor colorWithRed:2.0/255 + HIGHLIGHT_DARKNESS green:43.0/255 + HIGHLIGHT_DARKNESS blue:91.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	policiesButton.highlightedColor = [UIColor colorWithRed:2.0/255 + 2*HIGHLIGHT_DARKNESS green:43.0/255 + 2*HIGHLIGHT_DARKNESS blue:91.0/255 + 2*HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:policiesButton];
	
	NLWButton *contactsButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	contactsButton.frame = CGRectMake(screenDimensions.size.width / 2,
																		screenDimensions.size.height * 2 / 3,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 3);
	[contactsButton addTarget:self action:@selector(NDButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//	[contactsButton setTitle:@"ND" forState:UIControlStateNormal];
//	contactsButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
//	[contactsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	if(!IS_IPHONE_5)[contactsButton setBackgroundImage:[UIImage imageNamed:@"unit_logo.png"] forState:UIControlStateNormal];
	else [contactsButton setBackgroundImage:[UIImage imageNamed:@"unit_logo@2x_tall.png"] forState:UIControlStateNormal];
	contactsButton.unHighlightedColor = [UIColor colorWithRed:220.0/255 + 1*HIGHLIGHT_DARKNESS green:180.0/255 + 1*HIGHLIGHT_DARKNESS blue:57.0/255 + 1*HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	contactsButton.highlightedColor = [UIColor colorWithRed:220.0/255 + 2*HIGHLIGHT_DARKNESS green:180.0/255 + 2*HIGHLIGHT_DARKNESS blue:57.0/255 + 2*HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:contactsButton];

	[mapButton setHighlighted:NO];
	[scheduleButton setHighlighted:NO];
	[activitiesButton setHighlighted:NO];
	[speakersButton setHighlighted:NO];
	[policiesButton setHighlighted:NO];
	[contactsButton setHighlighted:NO];
	
}

-(void)buttonTapped:(UIButton *) button
{
	[self performSegueWithIdentifier:button.titleLabel.text sender:self];
}

-(void)NDButtonTapped:(UIButton *) button
{
	[self performSegueWithIdentifier:@"ND" sender:self];
}

-(void)informationButtonTapped:(UIButton*) button
{
	[self performSegueWithIdentifier:@"INFORMATION" sender:self];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
