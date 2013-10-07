//
//  NLWMapViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 8/26/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWMapViewController.h"

@interface NLWMapViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIWebView *map;

@end

@implementation NLWMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	[self.spinner startAnimating];
	self.map.hidden = YES;
	self.map.delegate = self;
	[self.map loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://map.nd.edu/"]]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self.spinner stopAnimating];
	self.map.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
