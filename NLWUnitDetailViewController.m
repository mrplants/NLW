//
//  NLWUnitDetailViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 9/12/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWUnitDetailViewController.h"

@interface NLWUnitDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebView;

@end

@implementation NLWUnitDetailViewController

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
	
	[self.descriptionWebView loadHTMLString:self.html baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
