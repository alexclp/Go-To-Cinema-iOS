
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
@synthesize dictionaryDateMovie;
@synthesize arrayWithDates;

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
	
	NSDate *currentDate = [self.arrayWithDates objectAtIndex:indexPath.row];
	Movie *currentMovie = [self.dictionaryDateMovie objectForKey:currentDate];
	cell.englishNameLabel.text = currentMovie.englishTitle;
	cell.romanianNameLabel.text = currentMovie.romanianTitle;
	cell.timeLabel.text = currentMovie.time;
	
	return cell;

}

- (void)sortItems
{	/*
	SortOptionsModalViewController *sovc = [[SortOptionsModalViewController alloc] initWithNibName:@"SortOptionsModalViewController" bundle:nil];
//	sovc.delegate = self;
	NSLog(@"array = %@", self.arrayWithDates);
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:sovc];
	[self presentViewController:navigationController animated:YES completion:nil];
	 */
	
	NSDate *currentDate = [NSDate date];
	 
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];

	self.arrayWithDates = [self.arrayWithDates sortedArrayUsingDescriptors:descriptors];
	[self.tableView reloadData];
}

- (NSMutableDictionary *)createDictionaryFromMoviesArray:(NSArray *)array
{
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	self.arrayWithDates = [[NSMutableArray alloc] init];
	NSDate *date = [[NSDate alloc] init];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm"];
	for (Movie *movie in array) {
		date = [dateFormatter dateFromString:movie.time];
		[self.arrayWithDates addObject:date];
//		[dictionary setObject:movie forKey:movie.time];
		[dictionary setObject:movie forKey:date];
	}
	return dictionary;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.title = @"Movies";
	self.dictionaryDateMovie = [self createDictionaryFromMoviesArray:self.arrayWithMovies];
	UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStylePlain target:self action:@selector(sortItems)];
	self.navigationItem.rightBarButtonItem = sortButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
