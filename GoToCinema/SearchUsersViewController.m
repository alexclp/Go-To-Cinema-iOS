//
//  SearchUsersViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 04.06.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "SearchUsersViewController.h"
#import "AFJSONRequestOperation.h"

@interface SearchUsersViewController ()

@end

@implementation SearchUsersViewController

@synthesize searchData;
@synthesize tableView;
@synthesize searchResult;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)search
{
//	http://cinemadistance.eu01.aws.af.cm/user/search?=aa
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://cinemadistance.eu01.aws.af.cm/user/search?=%@", self.searchData.text]];
	NSLog(@"url = %@", url);
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		NSLog(@"json = %@", JSON);
		self.searchResult = (NSArray *)JSON;
		[self handleDataFromSearchResult];
	} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		NSLog(@"error while searching = %@", error);
	}];
	[operation start];
}

- (void)handleDataFromSearchResult
{
	[self.tableView reloadData];
}

#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.searchResult.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	static NSString *identifier = @"cell";
	
	cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	NSDictionary *user = [self.searchResult objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [user objectForKey:@"nume"], [user objectForKey:@"prenume"]];
	
	return cell;
}



- (void)textFieldChanged
{
	[self search];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(textFieldChanged)
												 name:UITextFieldTextDidChangeNotification
											   object:self.searchData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
