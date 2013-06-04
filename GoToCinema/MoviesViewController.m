
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
#import "DetailMovieViewController.h"
#import "AFHTTPClient.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesViewController ()

@property (strong, nonatomic) DetailMovieViewController *detailMovieController;

@end

@implementation MoviesViewController

@synthesize arrayToShow;
@synthesize detailMovieController;
@synthesize cinemaLocation;
@synthesize rawData;
@synthesize keyValue;
@synthesize arrayOfSeconds;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
	
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
	
    return result;
}

#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = self.arrayToShow.count;
	return rows;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];

	Movie *movie = [self.arrayToShow objectAtIndex:indexPath.row];
	
	self.detailMovieController.movieToShow = movie;
//	self.detailMovieController.cinemaToShow = [self.cinemaLocation objectForKey:movie.cinema];
	self.detailMovieController.cinemaToShow = [self.keyValue objectForKey:movie.cinema];

	[self.navigationController pushViewController:self.detailMovieController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Movie Cell";
    
    MovieCustomCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (MovieCustomCell *)[MovieCustomCell cellFromNibNamed:@"MovieCustomCell"];
    }
	
	Movie *currentMovie = [self.arrayToShow objectAtIndex:indexPath.row];
	cell.cinemaLabel.text = currentMovie.cinema;
	cell.timeLabel.text = currentMovie.time;
	cell.romanianNameLabel.text = currentMovie.romanianTitle;
	cell.englishNameLabel.text = currentMovie.englishTitle;
	
	 __weak UITableViewCell *weakCell = cell;
	[cell.imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:currentMovie.imageLink]]
	   placeholderImage:[UIImage imageNamed:@"placeholder.png"]
									success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
										weakCell.imageView.image = image;
										[weakCell setNeedsLayout];
		   
									}
									failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
		    
									}];
	
	return cell;
}

- (NSDictionary *)createNewDictionary
{
	NSMutableDictionary *dictionaryToAdd = [NSMutableDictionary dictionary];
	
	for (NSDictionary *dictionary in self.rawData) {
		NSMutableArray *array = [NSMutableArray array];
		NSString *distance = [dictionary objectForKey:@"km"];
		NSString *min = [dictionary objectForKey:@"min"];
		NSString *name = [dictionary objectForKey:@"name"];
		NSString *lat = [dictionary objectForKey:@"lat_cinema"];
		NSString *lng = [dictionary objectForKey:@"lng_cinema"];
		[array addObjectsFromArray:@[distance, min, name, lat, lng]];
		[dictionaryToAdd setObject:array forKey:name];
	}
	return dictionaryToAdd.copy;
}

- (NSString *)timeFormatted:(int)totalSeconds
{
	
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
	
    return [NSString stringWithFormat:@"%02d:%02d",hours, minutes];
}

- (void)sortItems
{
//	self.arrayToShow = [self sortItemsByTravelDuration];
	self.arrayToShow = [[NSArray alloc] initWithArray:[self sortItemsByTravelDuration]];
	[self.tableView reloadData];
}

- (NSArray *)sortItemsByTravelDuration
{
	NSMutableArray *arrayToAdd = [NSMutableArray array];
	NSDate *currentDate = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm"];
	NSString *dateString = [dateFormatter stringFromDate:currentDate];
//	NSDate *startHour = [dateFormatter dateFromString:dateString];
	NSDate *startHour = [dateFormatter dateFromString:@"12:00"];
	
	for (Movie *movie in arrayToShow) {
		NSString *cinema = movie.cinema;
		NSString *duration = [[self.keyValue objectForKey:movie.cinema] objectAtIndex:1];
//		NSLog(@"arrival = %@", [self timeFormatted:duration.intValue]);
		NSTimeInterval toAdd = duration.intValue;
		NSDate *endHour = [startHour dateByAddingTimeInterval:toAdd];
		NSDate *movieHour = [dateFormatter dateFromString:movie.time];
		if ([endHour compare:movieHour] == NSOrderedAscending) {
			[arrayToAdd addObject:movie];
		}
	}
	
	return arrayToAdd.copy;
}

NSInteger dateSort(id num1, id num2, void *context)
{
	Movie *movie1 = (Movie *)num1;
	Movie *movie2 = (Movie *)num2;
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm"];
	NSDate *v1 = [dateFormatter dateFromString:movie1.time];
	NSDate *v2 = [dateFormatter dateFromString:movie2.time];
	
	return [v1 compare:v2];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	

	
	self.title = @"Filme";
	UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithTitle:@"Sortează" style:UIBarButtonItemStylePlain target:self action:@selector(sortItems)];
	self.navigationItem.rightBarButtonItem = sortButton;
	self.arrayToShow = [self.arrayToShow sortedArrayUsingFunction:dateSort context:NULL];
	self.detailMovieController = [[DetailMovieViewController alloc] initWithNibName:@"DetailMovieViewController" bundle:nil];
	self.keyValue = [[NSDictionary alloc] initWithDictionary:[self createNewDictionary]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
