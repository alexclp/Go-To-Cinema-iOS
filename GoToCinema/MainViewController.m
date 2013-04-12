//
//  MainViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 09.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "MainViewController.h"
#import "SBJson.h"
#import "MoviesViewController.h"
#import "Movie.h"
#import "LocationTimeOptionViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize rawData;
@synthesize locationManager;
@synthesize mvc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray *)parseRawDataFromURL:(NSURL *)url
{
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	[request setHTTPMethod:@"GET"];
	NSError *error = [[NSError alloc] init];
	NSHTTPURLResponse *response = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *stringFromData = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSDictionary *result = [parser objectWithString:stringFromData];
	return [result objectForKey:@"movies"];
	NSLog(@"raaaaw = %@", result);
}

- (NSArray *)createArrayOfMoviesFromRawData:(NSArray *)data
{
	NSMutableArray *arrayToAdd = [[NSMutableArray alloc] init];

	for (NSDictionary *dictionary in data) {
		Movie *movie = [[Movie alloc] init];
		movie.englishTitle = [dictionary objectForKey:@"titluEn"];
		movie.romanianTitle = [dictionary objectForKey:@"titluRo"];
		movie.time = [dictionary objectForKey:@"ora"];
		movie.cinema = [dictionary objectForKey:@"cinema"];
		[arrayToAdd addObject:movie];
	}
	return arrayToAdd.copy;
}

- (void)sendDataToViewController
{
	self.mvc = [[MoviesViewController alloc] init];
	
//	NSLog(@"array = %@", self.rawData);

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm"];
	NSDate *date = [NSDate date];
	NSString *stringFromDate = [dateFormatter stringFromDate:date];
//	NSDate *currentDate = [dateFormatter dateFromString:stringFromDate];
	NSDate *currentDate = [dateFormatter dateFromString:@"14:15"];
	
	NSMutableArray *arrayToAdd = [NSMutableArray array];
	NSArray *arrayWithData = [self createArrayOfMoviesFromRawData:self.rawData];
	
	NSLog(@"current date = %@", currentDate);
	
	for (Movie *movie in arrayWithData) {
		NSDate *movieDate = [dateFormatter dateFromString:movie.time];
		if ([currentDate compare:movieDate] == NSOrderedAscending) {
			[arrayToAdd addObject:movie];
		} else if ([currentDate compare:movieDate] == NSOrderedDescending) {
			continue;
		} else {
			[arrayToAdd addObject:movie];
		}
	}
	self.mvc.arrayToShow = [[NSArray alloc] initWithArray:arrayToAdd.copy];
}

#pragma mark user interaction methods

- (IBAction)seeMovies:(UIButton *)button
{
	[self sendDataToViewController];
	
	[self.navigationController pushViewController:mvc animated:YES];
}

- (IBAction)setTimeAndLocation:(UIButton *)button
{
	LocationTimeOptionViewController *vc = [[LocationTimeOptionViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

#pragma mark location

- (void)updateDeviceLocation
{
	NSString *latitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
	NSString *longitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
	
	self.currentLocation.text = [NSString stringWithFormat:@"latitude = %@\nlongitude = %@\n", latitude, longitude];
	
}

#pragma mark view methods

- (void)viewWillAppear:(BOOL)animated
{
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.distanceFilter = kCLDistanceFilterNone;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
	[self.locationManager startUpdatingLocation];
	
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self updateDeviceLocation];
	
	[super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.rawData = [[NSArray alloc] initWithArray:[self parseRawDataFromURL:[NSURL URLWithString:@"http://warm-eyrie-7268.herokuapp.com/date.json"]]];
	self.title = @"Action";
	
	[self updateDeviceLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
