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
#define isIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@interface NLWViewController ()

@property (nonatomic, strong) NSMutableArray * buttons;

@end

@implementation NLWViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	for (UIButton * button in self.buttons)
	{
    [button removeFromSuperview];
	}
	self.buttons = [[NSMutableArray alloc] init];
	
	NLWButton *newMapButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	NLWButton *newScheduleButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	NLWButton *newActivitiesButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	NLWButton *newSpeakersButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	NLWButton *newPoliciesButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	NLWButton *newContactsButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	
	[self.buttons addObject:newMapButton];
	[self.buttons addObject:newScheduleButton];
	[self.buttons addObject:newActivitiesButton];
	[self.buttons addObject:newSpeakersButton];
	[self.buttons addObject:newPoliciesButton];
	[self.buttons addObject:newContactsButton];
}

-(void)viewDidLayoutSubviews
{
	//iPhone
	//tall view is w=160, h=168
	//short view is w = 160, h = 139
		
	[super viewDidLayoutSubviews];
	
	CGRect screenDimensions = [UIScreen mainScreen].bounds;

	//if device is in landscape, switch the height and width
	if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
	{
		CGFloat temp = screenDimensions.size.width;
		screenDimensions.size.width = screenDimensions.size.height;
		screenDimensions.size.height = temp;
	}
	
	CGFloat heightOfNavBar = self.navigationController.navigationBar.frame.size.height;
	CGFloat heightOfStatusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
	
	//swithc it for landscape if that's the case
	if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) heightOfStatusBar = [UIApplication sharedApplication].statusBarFrame.size.width;
	
	screenDimensions.size.height-=heightOfNavBar;
	screenDimensions.size.height-=heightOfStatusBar;
	
	NSLog(@"button dimensions: %f, %f", screenDimensions.size.width / 2, screenDimensions.size.height / 3);
	
	NLWButton *mapButton = self.buttons[0];
	mapButton.frame = CGRectMake(0,
															 0,
															 screenDimensions.size.width / 2,
															 screenDimensions.size.height / 3 );
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
	mapButton.unHighlightedColor = [UIColor colorWithRed:220.0/255 + 1*HIGHLIGHT_DARKNESS green:180.0/255 + 1*HIGHLIGHT_DARKNESS blue:57.0/255 + 1*HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	mapButton.highlightedColor = [UIColor colorWithRed:220.0/255 + 2*HIGHLIGHT_DARKNESS green:180.0/255 + 2*HIGHLIGHT_DARKNESS blue:57.0/255 + 2*HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:mapButton];

	NLWButton *scheduleButton = self.buttons[1];
	scheduleButton.frame = CGRectMake(screenDimensions.size.width / 2,
																		0,
																		screenDimensions.size.width / 2 ,
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
	scheduleButton.unHighlightedColor = [UIColor colorWithRed:220.0/255 + 1*HIGHLIGHT_DARKNESS green:180.0/255 + 1*HIGHLIGHT_DARKNESS blue:57.0/255 + 1*HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	scheduleButton.highlightedColor = [UIColor colorWithRed:220.0/255 + 2*HIGHLIGHT_DARKNESS green:180.0/255 + 2*HIGHLIGHT_DARKNESS blue:57.0/255 + 2*HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:scheduleButton];
	
	NLWButton *activitiesButton = self.buttons[2];
	activitiesButton.frame = CGRectMake(0,
																			screenDimensions.size.height / 3,
																			screenDimensions.size.width / 2 ,
																			screenDimensions.size.height / 3 );
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
	activitiesButton.unHighlightedColor = [UIColor colorWithRed:220.0/255 + 1*HIGHLIGHT_DARKNESS green:180.0/255 + 1*HIGHLIGHT_DARKNESS blue:57.0/255 + 1*HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	activitiesButton.highlightedColor = [UIColor colorWithRed:220.0/255 + 2*HIGHLIGHT_DARKNESS green:180.0/255 + 2*HIGHLIGHT_DARKNESS blue:57.0/255 + 2*HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:activitiesButton];
	
	NLWButton *speakersButton = self.buttons[3];
	speakersButton.frame = CGRectMake(screenDimensions.size.width / 2,
																		screenDimensions.size.height / 3,
																		screenDimensions.size.width / 2 ,
																		screenDimensions.size.height / 3 );
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
	speakersButton.unHighlightedColor = [UIColor colorWithRed:220.0/255 + 1*HIGHLIGHT_DARKNESS green:180.0/255 + 1*HIGHLIGHT_DARKNESS blue:57.0/255 + 1*HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	speakersButton.highlightedColor = [UIColor colorWithRed:220.0/255 + 2*HIGHLIGHT_DARKNESS green:180.0/255 + 2*HIGHLIGHT_DARKNESS blue:57.0/255 + 2*HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:speakersButton];
	
	NLWButton *policiesButton = self.buttons[4];
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
	policiesButton.unHighlightedColor = [UIColor colorWithRed:220.0/255 + 1*HIGHLIGHT_DARKNESS green:180.0/255 + 1*HIGHLIGHT_DARKNESS blue:57.0/255 + 1*HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	policiesButton.highlightedColor = [UIColor colorWithRed:220.0/255 + 2*HIGHLIGHT_DARKNESS green:180.0/255 + 2*HIGHLIGHT_DARKNESS blue:57.0/255 + 2*HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:policiesButton];
	
	NLWButton *contactsButton = self.buttons[5];
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
	
	if(isIpad)
	{
		CGRect buttonFrame = mapButton.frame;
		[contactsButton setBackgroundImage:[UIImage imageNamed:@"NLW_appIcon_7_iPad.png"] forState:UIControlStateNormal];
		[policiesButton setBackgroundImage:[UIImage imageNamed:@"uncertain_?_iPad.png"] forState:UIControlStateNormal];
		[speakersButton setBackgroundImage:[UIImage imageNamed:@"classic_phone_iPad.png"] forState:UIControlStateNormal];
		[activitiesButton setBackgroundImage:[UIImage imageNamed:@"speaker_lecturn_iPad.png"] forState:UIControlStateNormal];
		[scheduleButton setBackgroundImage:[UIImage imageNamed:@"clock_iPad.png"] forState:UIControlStateNormal];
		[mapButton setBackgroundImage:[UIImage imageNamed:@"compass_rose_iPad.png"] forState:UIControlStateNormal];
	}

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
