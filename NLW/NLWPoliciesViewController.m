//
//  NLWPoliciesViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 8/30/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWPoliciesViewController.h"

@interface NLWPoliciesViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *policiesWebView;

@end

@implementation NLWPoliciesViewController

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
