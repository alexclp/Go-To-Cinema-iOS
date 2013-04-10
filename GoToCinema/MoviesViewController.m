//
//  MoviesViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 10.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "MoviesViewController.h"
#import "Movie.h"
#import "MovieCustomCell.h"
#import "SortOptionsModalViewController.h"

@interface MoviesViewController ()

@end

@implementation MoviesViewController

@synthesize arrayWithMovies;
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
	return arrayWithMovies.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Movie Cell";
    
    MovieCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (MovieCustomCell *)[MovieCustomCell cellFromNibNamed:@"MovieCustomCell"];
    }
	
	Movie *movie = [[Movie alloc] init];
	movie = [self.arrayWithMovies objectAtIndex:indexPath.row];
	
	cell.englishNameLabel.text = movie.englishTitle;
	cell.romanianNameLabel.text = movie.romanianTitle;
	cell.timeLabel.text = movie.time;
	
	return cell;

}

- (void)sortItems
{	
	SortOptionsModalViewController *sovc = [[SortOptionsModalViewController alloc] initWithNibName:@"SortOptionsModalViewController" bundle:nil];
//	sovc.delegate = self;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:sovc];
	[self presentViewController:navigationController animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.title = @"Movies";
	UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStylePlain target:self action:@selector(sortItems)];
	self.navigationItem.rightBarButtonItem = sortButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
