//
//  LoginViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 10.05.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "LoginViewController.h"
#import "SBJson.h"
#import "AFHTTPClient.h"
#import "MainViewController.h"
#import "PKRevealController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize user;
@synthesize password;
@synthesize loginButton;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)saveLoginData:(NSDictionary *)data
{
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];

	[data writeToFile:filePath atomically:YES];
}

- (NSString *)parseResponse:(NSString *)response
{
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSDictionary *result = [parser objectWithString:response];
	NSString *status = [NSString stringWithFormat:@"%@", [result objectForKey:@"loggedIn"]];
	[self saveLoginData:result];
	return status;
}

- (IBAction)login:(UIButton *)button
{
	[self.view endEditing:YES];
	
	NSURL *url = [NSURL URLWithString:@"http://cinemadistance.eu01.aws.af.cm"];
	AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							self.user.text, @"username",
							self.password.text, @"password", nil];
	

	[httpClient postPath:@"/user/login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		
		NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
		NSLog(@"Succes, response = %@", responseString);
		NSString *status = [self parseResponse:responseString];
		if ([status isEqualToString:@"1"]) {
			MainViewController *mvc = [[MainViewController alloc] init];
			[self.navigationController pushViewController:mvc animated:YES];
		} else {
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Wrong user name or password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertView show];
		}
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Request failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
	}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.revealController.recognizesPanningOnFrontView = NO;
	self.title = @"Login screen";
	self.user.text = @"alex";
	self.password.text = @"1234";
}


- (void)viewWillAppear:(BOOL)animated
{
	self.revealController.recognizesPanningOnFrontView = NO;
	
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
