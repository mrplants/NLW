//
//  NLWSpeakersViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 9/9/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWSpeakersViewController.h"
#import "NLWButton.h"
#import "Constants.h"
#import "Keys.h"
#import "NLWSpeakerDetailViewController.h"
#import <Parse/Parse.h>

@interface NLWSpeakersViewController ()

@property (nonatomic, strong) NSArray * speakers;
@property (nonatomic, strong) NSArray * speakersButtons;
@property int selectedIndex;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation NLWSpeakersViewController

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
	self.speakers = @[@{}, @{}, @{}, @{}, @{}, @{}, @{}];
	[self pullSpeakers];
	// Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
//	[self layoutButtons];
}

-(void)pullSpeakers
{
	[self.spinner startAnimating];
	//turn on the network spinner
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	//build the query that will return the scheduled events
	PFQuery * queryForToppings = [PFQuery queryWithClassName:PARSE_SPEAKERS_CLASS];
	
	//execute the query in the background.
	[queryForToppings findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
		if (!error) {//the query succeeded
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			
			NSMutableArray * tempSpeakers = [[NSMutableArray alloc] init];
			
			for (PFObject * policy in objects)
			{
				NSDictionary * speakersDict = @{PARSE_SPEAKERS_TITLE: [policy objectForKey:PARSE_SPEAKERS_TITLE],PARSE_SPEAKERS_DETAIL_HTML: [policy objectForKey:PARSE_SPEAKERS_DETAIL_HTML],PARSE_SPEAKERS_IMAGE_URL: [policy objectForKey:PARSE_SPEAKERS_IMAGE_URL],PARSE_SPEAKERS_NUMBER: [policy objectForKey:PARSE_SPEAKERS_NUMBER]};
				[tempSpeakers addObject:speakersDict];
			}
			
			self.speakers = [tempSpeakers copy];
			
			for(NSDictionary * speaker in self.speakers)
			{
				tempSpeakers[[speaker[PARSE_SPEAKERS_NUMBER] intValue]] = speaker;
			}
			
			self.speakers = [tempSpeakers copy];
			
			dispatch_async(dispatch_get_main_queue(), ^(void){
				[self layoutButtons];
				[self.spinner stopAnimating];
			});
			
		} else { //the query did not succeed.
			
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			[self.navigationController popViewControllerAnimated:YES];
			[[[UIAlertView alloc] initWithTitle:@"Speakers Not Available"
																	message:@"Could not retrieve the list of Speakers. We apologize for the inconvenience."
																 delegate:self
												cancelButtonTitle:@"OK"
												otherButtonTitles: nil] show];
			
		}
	}];
}

-(void)layoutButtons
{
	for (NLWButton * button in self.speakersButtons)
	{
    [button removeFromSuperview];
	}
	
	CGRect screenDimensions = [UIScreen mainScreen].bounds;
	CGFloat heightOfNavBar = self.navigationController.navigationBar.frame.size.height;
	CGFloat heightOfStatusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
	screenDimensions.size.height-=heightOfNavBar;
	screenDimensions.size.height-=heightOfStatusBar;
	
	
	NLWButton *speaker0Button = [NLWButton buttonWithType:UIButtonTypeCustom];
	speaker0Button.frame = CGRectMake(0,
																		0,
																		screenDimensions.size.width,
																		screenDimensions.size.height / 4);
	[speaker0Button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];

	UIImageView * speaker0ImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.speakers[0][PARSE_SPEAKERS_IMAGE_URL]]]]];
	speaker0ImageView.frame = CGRectMake(speaker0Button.frame.size.height / 8, speaker0Button.frame.size.height / 8, speaker0Button.frame.size.height * 6 / 8, speaker0Button.frame.size.height *6 / 8);
	speaker0ImageView.contentMode = UIViewContentModeScaleAspectFit;
	[speaker0Button addSubview:speaker0ImageView];
	
	[speaker0Button setTitle:self.speakers[0][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	[speaker0Button setTitleEdgeInsets:UIEdgeInsetsMake(speaker0Button.frame.size.height / 8, speaker0Button.frame.size.height, speaker0Button.frame.size.height / 8, speaker0Button.frame.size.height / 8)];
	speaker0Button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	speaker0Button.titleLabel.textAlignment = NSTextAlignmentCenter;
	
	speaker0Button.unHighlightedColor = [UIColor colorWithRed:220.0/255 green:180.0/255 blue:57.0/255 alpha:1.0];
	//unhighlighted is just highlighted plus a constant
	speaker0Button.highlightedColor = [UIColor colorWithRed:220.0/255 + HIGHLIGHT_DARKNESS green:180.0/255 + HIGHLIGHT_DARKNESS blue:57.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	
	[self.view addSubview:speaker0Button];
	
	
	
	NLWButton *speaker1Button = [NLWButton buttonWithType:UIButtonTypeCustom];
	speaker1Button.frame = CGRectMake(0,
																		screenDimensions.size.height / 4,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 4);
	[speaker1Button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[speaker1Button setTitle:self.speakers[1][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	
	UIImageView * speaker1ImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.speakers[1][PARSE_SPEAKERS_IMAGE_URL]]]]];
	speaker1ImageView.frame = CGRectMake(speaker1Button.frame.size.height / 10, speaker1Button.frame.size.height / 20, speaker1Button.frame.size.height / 2, speaker1Button.frame.size.height * 9 / 20);
	speaker1ImageView.center = CGPointMake(speaker1Button.frame.size.width / 2, speaker1ImageView.center.y);
	speaker1ImageView.contentMode = UIViewContentModeScaleAspectFit;
	[speaker1Button addSubview:speaker1ImageView];
	
	[speaker1Button setTitle:self.speakers[1][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	[speaker1Button setTitleEdgeInsets:UIEdgeInsetsMake(speaker1Button.frame.size.height / 2, speaker1Button.frame.size.width / 10, speaker1Button.frame.size.height / 10, speaker1Button.frame.size.width / 10)];
	speaker1Button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	speaker1Button.titleLabel.textAlignment = NSTextAlignmentCenter;
	
	speaker1Button.unHighlightedColor = [UIColor colorWithRed:0/255 green:15.0/255 blue:84.0/255 alpha:1.0];
	//unhighlighted is just highlighted plus a constant
	speaker1Button.highlightedColor = [UIColor colorWithRed:0/255 + HIGHLIGHT_DARKNESS green:15.0/255 + HIGHLIGHT_DARKNESS blue:84.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:speaker1Button];
	
	NLWButton *speaker2Button = [NLWButton buttonWithType:UIButtonTypeCustom];
	speaker2Button.frame = CGRectMake(screenDimensions.size.width / 2,
																		screenDimensions.size.height / 4,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 4);
	[speaker2Button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[speaker2Button setTitle:self.speakers[2][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];

	UIImageView * speaker2ImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.speakers[2][PARSE_SPEAKERS_IMAGE_URL]]]]];
	speaker2ImageView.frame = CGRectMake(speaker2Button.frame.size.height / 10, speaker2Button.frame.size.height / 20, speaker2Button.frame.size.height / 2, speaker2Button.frame.size.height * 9 / 20);
	speaker2ImageView.center = CGPointMake(speaker2Button.frame.size.width / 2, speaker2ImageView.center.y);
	speaker2ImageView.contentMode = UIViewContentModeScaleAspectFit;
	[speaker2Button addSubview:speaker2ImageView];
	
	[speaker2Button setTitle:self.speakers[2][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	[speaker2Button setTitleEdgeInsets:UIEdgeInsetsMake(speaker2Button.frame.size.height / 2, speaker2Button.frame.size.width / 10, speaker2Button.frame.size.height / 10, speaker2Button.frame.size.width / 10)];
	speaker2Button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	speaker2Button.titleLabel.textAlignment = NSTextAlignmentCenter;

	speaker2Button.unHighlightedColor = [UIColor colorWithRed:2.0/255 green:43.0/255 blue:91.0/255 alpha:1.0];
	//unhighlighted is just highlighted plus a constant
	speaker2Button.highlightedColor = [UIColor colorWithRed:2.0/255 + HIGHLIGHT_DARKNESS green:43.0/255 + HIGHLIGHT_DARKNESS blue:91.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:speaker2Button];
	
	NLWButton *speaker3Button = [NLWButton buttonWithType:UIButtonTypeCustom];
	speaker3Button.frame = CGRectMake(0,
																		screenDimensions.size.height * 2 / 4,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 4);
	[speaker3Button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[speaker3Button setTitle:self.speakers[3][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];

	UIImageView * speaker3ImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.speakers[3][PARSE_SPEAKERS_IMAGE_URL]]]]];
	speaker3ImageView.frame = CGRectMake(speaker3Button.frame.size.height / 10, speaker3Button.frame.size.height / 20, speaker3Button.frame.size.height / 2, speaker3Button.frame.size.height * 9 / 20);
	speaker3ImageView.center = CGPointMake(speaker3Button.frame.size.width / 2, speaker3ImageView.center.y);
	speaker3ImageView.contentMode = UIViewContentModeScaleAspectFit;
	[speaker3Button addSubview:speaker3ImageView];
	
	[speaker3Button setTitle:self.speakers[3][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	[speaker3Button setTitleEdgeInsets:UIEdgeInsetsMake(speaker3Button.frame.size.height / 2, speaker3Button.frame.size.width / 10, speaker1Button.frame.size.height / 10, speaker3Button.frame.size.width / 10)];
	speaker3Button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	speaker3Button.titleLabel.textAlignment = NSTextAlignmentCenter;

	speaker3Button.unHighlightedColor = [UIColor colorWithRed:0/255 + 0.5 * HIGHLIGHT_DARKNESS green:15.0/255 + 0.5 * HIGHLIGHT_DARKNESS blue:84.0/255 + 0.5 * HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just highlighted plus a constant
	speaker3Button.highlightedColor = [UIColor colorWithRed:0/255 + 1.5 * HIGHLIGHT_DARKNESS green:15.0/255 + 1.5 * HIGHLIGHT_DARKNESS blue:84.0/255 + 1.5 * HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:speaker3Button];
	
	NLWButton *speaker4Button = [NLWButton buttonWithType:UIButtonTypeCustom];
	speaker4Button.frame = CGRectMake(screenDimensions.size.width / 2,
																		screenDimensions.size.height * 2 / 4,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 4);
	[speaker4Button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[speaker4Button setTitle:self.speakers[4][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	
	UIImageView * speaker4ImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.speakers[4][PARSE_SPEAKERS_IMAGE_URL]]]]];
	speaker4ImageView.frame = CGRectMake(speaker4Button.frame.size.height / 10, speaker4Button.frame.size.height / 20, speaker4Button.frame.size.height / 2, speaker4Button.frame.size.height * 9 / 20);
	speaker4ImageView.center = CGPointMake(speaker4Button.frame.size.width / 2, speaker4ImageView.center.y);
	speaker4ImageView.contentMode = UIViewContentModeScaleAspectFit;
	[speaker4Button addSubview:speaker4ImageView];
	
	[speaker4Button setTitle:self.speakers[4][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	[speaker4Button setTitleEdgeInsets:UIEdgeInsetsMake(speaker4Button.frame.size.height / 2, speaker4Button.frame.size.width / 10, speaker1Button.frame.size.height / 10, speaker4Button.frame.size.width / 10)];
	speaker4Button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	speaker4Button.titleLabel.textAlignment = NSTextAlignmentCenter;
	
	speaker4Button.unHighlightedColor = [UIColor colorWithRed:2.0/255 + 0.5 * HIGHLIGHT_DARKNESS green:43.0/255 + 0.5 * HIGHLIGHT_DARKNESS blue:91.0/255 + 0.5 * HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just highlighted plus a constant
	speaker4Button.highlightedColor = [UIColor colorWithRed:2.0/255 + 1.5 * HIGHLIGHT_DARKNESS green:43.0/255 + 1.5* HIGHLIGHT_DARKNESS blue:91.0/255 + 1.5 * HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:speaker4Button];
	
	NLWButton *speaker5Button = [NLWButton buttonWithType:UIButtonTypeCustom];
	speaker5Button.frame = CGRectMake(0,
																		screenDimensions.size.height * 3 / 4,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 4);
	[speaker5Button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[speaker5Button setTitle:self.speakers[5][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	
	UIImageView * speaker5ImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.speakers[5][PARSE_SPEAKERS_IMAGE_URL]]]]];
	speaker5ImageView.frame = CGRectMake(speaker5Button.frame.size.height / 10, speaker5Button.frame.size.height / 20, speaker5Button.frame.size.height / 2, speaker5Button.frame.size.height * 9 / 20);
	speaker5ImageView.center = CGPointMake(speaker5Button.frame.size.width / 2, speaker5ImageView.center.y);
	speaker5ImageView.contentMode = UIViewContentModeScaleAspectFit;
	[speaker5Button addSubview:speaker5ImageView];
	
	[speaker5Button setTitle:self.speakers[5][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	[speaker5Button setTitleEdgeInsets:UIEdgeInsetsMake(speaker5Button.frame.size.height / 2, speaker5Button.frame.size.width / 10, speaker1Button.frame.size.height / 10, speaker5Button.frame.size.width / 10)];
	speaker5Button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	speaker5Button.titleLabel.textAlignment = NSTextAlignmentCenter;
	
	speaker5Button.unHighlightedColor = [UIColor colorWithRed:0/255 + HIGHLIGHT_DARKNESS green:15.0/255 + HIGHLIGHT_DARKNESS blue:84.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just highlighted plus a constant
	speaker5Button.highlightedColor = [UIColor colorWithRed:0/255 + 2.0 * HIGHLIGHT_DARKNESS green:15.0/255 + 2.0 * HIGHLIGHT_DARKNESS blue:84.0/255 + 2.0 * HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:speaker5Button];

	NLWButton *speaker6Button = [NLWButton buttonWithType:UIButtonTypeCustom];
	speaker6Button.frame = CGRectMake(screenDimensions.size.width / 2,
																		screenDimensions.size.height * 3 / 4,
																		screenDimensions.size.width / 2,
																		screenDimensions.size.height / 4);
	[speaker6Button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	[speaker6Button setTitle:self.speakers[6][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	
	UIImageView * speaker6ImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.speakers[6][PARSE_SPEAKERS_IMAGE_URL]]]]];
	speaker6ImageView.frame = CGRectMake(speaker6Button.frame.size.height / 10, speaker6Button.frame.size.height / 20, speaker6Button.frame.size.height / 2, speaker6Button.frame.size.height * 9 / 20);
	speaker6ImageView.center = CGPointMake(speaker6Button.frame.size.width / 2, speaker6ImageView.center.y);
	speaker6ImageView.contentMode = UIViewContentModeScaleAspectFit;
	[speaker6Button addSubview:speaker6ImageView];
	
	[speaker6Button setTitle:self.speakers[6][PARSE_SPEAKERS_TITLE] forState:UIControlStateNormal];
	[speaker6Button setTitleEdgeInsets:UIEdgeInsetsMake(speaker6Button.frame.size.height / 2, speaker6Button.frame.size.width / 10, speaker1Button.frame.size.height / 10, speaker6Button.frame.size.width / 10)];
	speaker6Button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	speaker6Button.titleLabel.textAlignment = NSTextAlignmentCenter;
	
	speaker6Button.unHighlightedColor = [UIColor colorWithRed:2.0/255 + HIGHLIGHT_DARKNESS green:43.0/255 + HIGHLIGHT_DARKNESS blue:91.0/255 + HIGHLIGHT_DARKNESS alpha:1.0];
	//unhighlighted is just highlighted plus a constant
	speaker6Button.highlightedColor = [UIColor colorWithRed:2.0/255 + 2.0 * HIGHLIGHT_DARKNESS green:43.0/255 + 2.0 * HIGHLIGHT_DARKNESS blue:91.0/255 + 2.0 * HIGHLIGHT_DARKNESS alpha:1.0];
	[self.view addSubview:speaker6Button];

	[speaker0Button setHighlighted:NO];
	[speaker1Button setHighlighted:NO];
	[speaker2Button setHighlighted:NO];
	[speaker3Button setHighlighted:NO];
	[speaker4Button setHighlighted:NO];
	[speaker5Button setHighlighted:NO];
	[speaker6Button setHighlighted:NO];
	
	self.speakersButtons = @[speaker0Button, speaker1Button, speaker2Button, speaker3Button, speaker4Button, speaker5Button, speaker6Button];
	
}

-(void)buttonTapped:(UIButton *) button
{
	int index;
	if ([button isEqual:self.speakersButtons[0]])
	{
		index = 0;
	} else if([button isEqual:self.speakersButtons[1]])
	{
		index = 1;
	} else if([button isEqual:self.speakersButtons[2]])
	{
		index = 2;
	} else if([button isEqual:self.speakersButtons[3]])
	{
		index = 3;
	} else if([button isEqual:self.speakersButtons[4]])
	{
		index = 4;
	} else if([button isEqual:self.speakersButtons[5]])
	{
		index = 5;
	} else if([button isEqual:self.speakersButtons[6]])
	{
		index = 6;
	}

	self.selectedIndex = index;
	
	[self performSegueWithIdentifier:@"Speakers Detail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[super prepareForSegue:segue sender:sender];
	if ([segue.identifier isEqualToString:@"Speakers Detail"])
	{
		NLWSpeakerDetailViewController * destinationVC = segue.destinationViewController;
		destinationVC.html = self.speakers[self.selectedIndex][PARSE_SPEAKERS_DETAIL_HTML];
	}
}

- (void)didReceiveMemoryWarning
{	
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
