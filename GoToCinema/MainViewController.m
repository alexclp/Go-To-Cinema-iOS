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

#pragma mark user interaction methods

- (IBAction)seeMovies:(UIButton *)button
{
	MoviesViewController *mvc = [[MoviesViewController alloc] init];
	mvc.arrayWithMovies = [[NSArray alloc] initWithArray:[self createArrayOfMoviesFromRawData:self.rawData]];
	[self.navigationController pushViewController:mvc animated:YES];
}

- (IBAction)setTimeAndLocation:(UIButton *)button
{
	LocationTimeOptionViewController *vc = [[LocationTimeOptionViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

#pragma mark view methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.rawData = [self parseRawDataFromURL:[NSURL URLWithString:@"http://warm-eyrie-7268.herokuapp.com/date.json"]];
	self.title = @"Action";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
