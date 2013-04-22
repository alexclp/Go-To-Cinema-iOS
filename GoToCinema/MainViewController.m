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
#import "Cinema.h"
#import "LocationTimeOptionViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize rawData;
@synthesize locationManager;
@synthesize mvc;
@synthesize cinemaLocations;
@synthesize cinemaDistances;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)getDistancesFromCurrentLocation:(CLLocationManager *)location
{
//	NSString *longitude = [NSString stringWithFormat:@"%f", location.location.coordinate.longitude];
//	NSString *latitude = [NSString stringWithFormat:@"%f", location.location.coordinate.latitude];
	
	NSString *longitude = @"26.1266510";
	NSString *latitude = @"44.419560";
	
//	NSLog(@"longitude = %@", longitude);
//	NSLog(@"latitude = %@", latitude);
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	
	NSString *URLString = [NSString stringWithFormat:@"http://thawing-fortress-7476.herokuapp.com/getDistance.php?lat=%@&lng=%@", latitude, longitude];
	NSURL *url = [NSURL URLWithString:URLString];
//	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	
	NSMutableURLRequest *request = [NSURLRequest requestWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
//	[request setHTTPMethod:@"GET"];
//	NSError *error = [[NSError alloc] init];
//	NSHTTPURLResponse *responseCode = nil;
	
//    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
	
//	NSString *stringFromData = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
	
//	NSDictionary *result = [parser objectWithString:stringFromData];
	
//	return [result objectForKey:@"cinema"];
}

- (NSArray *)parseCinemaLocations
{
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"places" ofType:@"json"];
	NSString *stringToParse = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
	
	NSDictionary *result = [parser objectWithString:stringToParse];
	return [result objectForKey:@"cinemas"];
}

- (NSDictionary *)createArrayOfCinemaLocationsFromRawData:(NSArray *)data
{
	NSMutableDictionary *dictionaryToAdd = [[NSMutableDictionary alloc] init];
	
	for (NSDictionary *dictionary in data) {
		Cinema *cinema = [[Cinema alloc] init];
		cinema.name = [dictionary objectForKey:@"name"];
		cinema.longitude = [dictionary objectForKey:@"lng"];
		cinema.latitude = [dictionary objectForKey:@"lat"];
		[dictionaryToAdd setObject:cinema forKey:cinema.name];
	}
	return dictionaryToAdd.copy;
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
		movie.rating = [dictionary objectForKey:@"nota"];
		movie.genre = [dictionary objectForKey:@"gen"];
		movie.cast = [dictionary objectForKey:@"actori"];
		movie.director = [dictionary objectForKey:@"regizor"];
		[arrayToAdd addObject:movie];
	}
	return arrayToAdd.copy;
}

- (void)sendDataToViewController
{
	self.mvc = [[MoviesViewController alloc] init];

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm"];
	NSDate *date = [NSDate date];
	NSString *stringFromDate = [dateFormatter stringFromDate:date];
//	NSDate *currentDate = [dateFormatter dateFromString:stringFromDate];
	NSDate *currentDate = [dateFormatter dateFromString:@"21:30"];
	
	NSMutableArray *arrayToAdd = [NSMutableArray array];
	NSArray *arrayWithData = [self createArrayOfMoviesFromRawData:self.rawData];
	
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
	
	self.mvc.cinemaLocation = [[NSDictionary alloc] initWithDictionary:[self createArrayOfCinemaLocationsFromRawData:[self parseCinemaLocations]]];
	self.mvc.arrayToShow = [[NSArray alloc] initWithArray:arrayToAdd.copy];
}

#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSLog(@"received response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSLog(@"received data");
	
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSString *stringFromData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSDictionary *dictionary = [NSDictionary dictionary];
	dictionary = [parser objectWithString:stringFromData];
	
	
	self.cinemaDistances = [[NSArray alloc] initWithArray:[dictionary objectForKey:@"cinema"]];
	NSLog(@"lala = %@", self.cinemaDistances);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"failed with error");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"finished loading");
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
	
//	self.cinemaDistances = [[NSDictionary alloc] initWithDictionary:[self getDistancesFromCurrentLocation:self.locationManager]];
	
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
	self.rawData = [[NSArray alloc] initWithArray:[self parseRawDataFromURL:[NSURL URLWithString:@"http://parsercinema.eu01.aws.af.cm/date.json"]]];
	self.title = @"Action";
	
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.distanceFilter = kCLDistanceFilterNone;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
	[self.locationManager startUpdatingLocation];
	
	[self getDistancesFromCurrentLocation:self.locationManager];
	
	[self updateDeviceLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
