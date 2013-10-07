//
//  NLWAttractionsDetailViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 9/8/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWAttractionsDetailViewController.h"

@interface NLWAttractionsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *policiesWebView;

@end

@implementation NLWAttractionsDetailViewController

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
	// Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	
	[self.policiesWebView loadHTMLString:self.html baseURL:nil];
	//	self.navigationItem.title = self.header;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
