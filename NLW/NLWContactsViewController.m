//
//  NLWContactsViewController.m
//  NLW
//
//  Created by Sean Fitzgerald on 8/30/13.
//  Copyright (c) 2013 Sean T Fitzgerald. All rights reserved.
//

#import "NLWContactsViewController.h"
#import <Parse/Parse.h>
#import "Keys.h"

@interface NLWContactsViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *contactsWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitingSpinner;

@end

@implementation NLWContactsViewController

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
	
//	NSString * contacts = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Contacts"
//																																													 ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
	
	self.contactsWebView.delegate = self;
	[self.waitingSpinner startAnimating];
	self.contactsWebView.hidden = YES;
	
	self.contactsWebView.scrollView.bounces = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self pullContactsPage];

}

-(void)pullContactsPage
{
	
	//turn on the network spinner
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	//build the query that will return the scheduled events
	PFQuery * queryForContactsHTML = [PFQuery queryWithClassName:PARSE_CONTACTS_CLASS];
	
	//execute the query in the background.
	[queryForContactsHTML findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
		if (!error) {//the query succeeded
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			
			//there's only one object
			[self.contactsWebView loadHTMLString:[objects[0] objectForKey:PARSE_CONTACTS_DETAIL_HTML] baseURL:nil];
			dispatch_async(dispatch_get_main_queue(), ^(void){
				[self.waitingSpinner stopAnimating];
			});

		} else { //the query did not succeed.
			
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; //turn off the network indicator
			[self.navigationController popViewControllerAnimated:YES];
			[[[UIAlertView alloc] initWithTitle:@"Contacts Not Available"
																	message:@"Could not retrieve the list of contacts. We apologize for the inconvenience."
																 delegate:self
												cancelButtonTitle:@"OK"
												otherButtonTitles: nil] show];
			
		}
	}];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	dispatch_async(dispatch_get_main_queue(), ^(void){
		[self.waitingSpinner stopAnimating];
		self.contactsWebView.hidden = NO;
	});
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
