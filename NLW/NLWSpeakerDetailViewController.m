//
//  NLWSpeakerDetailViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 8/30/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWSpeakerDetailViewController.h"

@interface NLWSpeakerDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebView;

@end

@implementation NLWSpeakerDetailViewController

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
	[self.descriptionWebView loadHTMLString:self.html baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
