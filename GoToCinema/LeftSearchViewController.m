//
//  LeftSearchViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 11.05.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "LeftSearchViewController.h"
#import "SearchUsersViewController.h"
#import "PKRevealController.h"

@interface LeftSearchViewController ()

@end

@implementation LeftSearchViewController

@synthesize tableView;

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
	return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 0) {
		
	} else if (indexPath.row == 1) {
		SearchUsersViewController *vc = [[SearchUsersViewController alloc] init];
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
		[self.revealController setFrontViewController:navController];
		[self.revealController showViewController:self.revealController.frontViewController];
	} else if (indexPath.row == 2) {
		
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	static NSString *identifier = @"cell";
	
	cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Profilul tău";
	} else if (indexPath.row == 1) {
		cell.textLabel.text = @"Caută alt utilizator";
	} else if (indexPath.row == 2) {
		cell.textLabel.text = @"Filme";
	}
	return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
