//
//  SortOptionsModalViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 10.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "SortOptionsModalViewController.h"
#import "MoviesViewController.h"
#import "Movie.h"

@interface SortOptionsModalViewController ()

@end

@implementation SortOptionsModalViewController

@synthesize tableView;
@synthesize moviesControlller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = 2;
	return rows;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableView *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cell";
	UITableViewCell *cell = nil;
	cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
	}
	
	if (indexPath.row == 0) {
		cell.textLabel.text = @"By time";
	} else if (indexPath.row == 1) {
		cell.textLabel.text = @"By location";
	}
	
	return cell;
}


#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.title = @"Sort options";
	self.moviesControlller = [[MoviesViewController alloc] initWithNibName:@"MoviesViewController" bundle:nil];
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewControllerAnimated:completion:)];
	self.navigationItem.rightBarButtonItem = cancelButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
