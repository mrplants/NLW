//
//  NLWInformationViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 9/8/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWInformationViewController.h"
#import "Constants.h"
#import "NLWButton.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface NLWInformationViewController ()

@end

@implementation NLWInformationViewController

-(void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	CGRect screenDimensions = [UIScreen mainScreen].bounds;
	CGFloat heightOfNavBar = self.navigationController.navigationBar.frame.size.height;
	CGFloat heightOfStatusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
	screenDimensions.size.height-=heightOfNavBar;
	screenDimensions.size.height-=heightOfStatusBar;
	
	
	NLWButton *policiesButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	policiesButton.frame = CGRectMake(0,
															 0,
															 screenDimensions.size.width,
															 screenDimensions.size.height / 2);
	[policiesButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[policiesButton setTitle:@"POLICIES" forState:UIControlStateNormal];
	policiesButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]*2];
	if(!IS_IPHONE_5)[policiesButton setBackgroundImage:[UIImage imageNamed:@"rules_icon.png"] forState:UIControlStateNormal];
	else [policiesButton setBackgroundImage:[UIImage imageNamed:@"rules_icon@2x_tall.png"] forState:UIControlStateNormal];
	policiesButton.unHighlightedColor = [UIColor colorWithRed:2.0/255 green:43.0/255 blue:91.0/255 alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	policiesButton.highlightedColor = [UIColor colorWithRed:2.0/255 + HIGHLIGHT_DARKNESS green:43.0/255 + HIGHLIGHT_DARKNESS blue:91.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	[policiesButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
	[policiesButton setTitleEdgeInsets:UIEdgeInsetsMake(policiesButton.frame.size.height * 10 / 12,
																											0,
																											policiesButton.frame.size.height / 12,
																											0)];
	[self.view addSubview:policiesButton];
	
	NLWButton *attractionsButton = [NLWButton buttonWithType:UIButtonTypeCustom];
	attractionsButton.frame = CGRectMake(0,
																		screenDimensions.size.height / 2,
																		screenDimensions.size.width,
																		screenDimensions.size.height / 2);
	[attractionsButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[attractionsButton setTitle:@"LOCAL ATTRACTIONS" forState:UIControlStateNormal];
	attractionsButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]*2];
	if(!IS_IPHONE_5)[attractionsButton setBackgroundImage:[UIImage imageNamed:@"buildings_icon.png"] forState:UIControlStateNormal];
	else [attractionsButton setBackgroundImage:[UIImage imageNamed:@"buildings_icon@2x_tall.png"] forState:UIControlStateNormal];
	attractionsButton.unHighlightedColor = [UIColor colorWithRed:220.0/255 green:180.0/255 blue:57.0/255 alpha:1.0];
	//unhighlighted is just unhighlighted plus a constant
	attractionsButton.highlightedColor = [UIColor colorWithRed:220.0/255 + HIGHLIGHT_DARKNESS green:180.0/255 + HIGHLIGHT_DARKNESS blue:57.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	[attractionsButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
	[attractionsButton setTitleEdgeInsets:UIEdgeInsetsMake(attractionsButton.frame.size.height * 10 / 12,
																											0,
																											attractionsButton.frame.size.height / 12,
																											0)];
	[self.view addSubview:attractionsButton];
	
	[policiesButton setHighlighted:NO];
	[attractionsButton setHighlighted:NO];
}

-(void)buttonTapped:(UIButton *) button
{
	[self performSegueWithIdentifier:button.titleLabel.text sender:self];
}

@end
