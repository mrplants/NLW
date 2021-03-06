//
//  NLWScheduleDetailViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 8/26/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWScheduleDetailViewController.h"

@interface NLWScheduleDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebView;

@end

@implementation NLWScheduleDetailViewController

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
	[self.descriptionWebView loadHTMLString:self.description baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
