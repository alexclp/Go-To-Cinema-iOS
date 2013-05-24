//
//  DetailMovieViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 13.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "DetailMovieViewController.h"
#import "Movie.h"
#import "Cinema.h"

#define METERS_PER_MILE 1609.344

@interface DetailMovieViewController ()

@end

@implementation DetailMovieViewController

@synthesize ratingLabel;
@synthesize genreLabel;
@synthesize castLabel;
@synthesize directorLabel;
@synthesize movieToShow;
@synthesize cinemaToShow;
@synthesize distanceLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateDurationLabel
{
	NSString *secondsString = self.cinemaToShow[1];
	int seconds = secondsString.intValue;
	
	int forHours = seconds / 3600;
	int remainder = seconds % 3600;
	int forMinutes = remainder / 60;
	int forSeconds = remainder % 60;
	self.distanceLabel.text = [NSString stringWithFormat:@"Poti ajunge in %d:%d (%@)", forHours, forMinutes, [self.cinemaToShow objectAtIndex:0]];
}

- (void)viewWillAppear:(BOOL)animated
{
	self.title = self.movieToShow.englishTitle;
	self.ratingLabel.text = self.movieToShow.rating;
	self.genreLabel.text = self.movieToShow.genre;
	self.castLabel.text = self.movieToShow.cast;
	self.directorLabel.text = self.movieToShow.director;
//	self.distanceLabel.text = [self.cinemaToShow objectAtIndex:0];
	NSLog(@"m = %@", self.movieToShow.rating);
	
//	set the MKMapView location to cinema's location
	
	// 1
    CLLocationCoordinate2D zoomLocation;
//    zoomLocation.latitude = self.cinemaToShow.latitude.doubleValue;
//    zoomLocation.longitude= self.cinemaToShow.longitude.doubleValue;
	
	NSString *lat = self.cinemaToShow[3];
	NSString *lng = self.cinemaToShow[4];
	NSString *name = self.cinemaToShow[2];
	
	zoomLocation.latitude = lat.doubleValue;
	zoomLocation.longitude = lng.doubleValue;
	
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
	
    // 3
    [self.mapView setRegion:viewRegion animated:YES];
		
	
	CLLocationCoordinate2D annotationCoord;
	
//	annotationCoord.latitude = self.cinemaToShow.latitude.doubleValue;
//	annotationCoord.longitude = self.cinemaToShow.longitude.doubleValue;
	
	annotationCoord.latitude = lat.doubleValue;
	annotationCoord.longitude = lng.doubleValue;
	
	MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
	annotationPoint.coordinate = annotationCoord;
	annotationPoint.title = name;
	[self.mapView addAnnotation:annotationPoint];
	
	
	[self updateDurationLabel];
	
	[super viewWillAppear:animated];
}

- (IBAction)openInMaps:(UIButton *)button
{
	Class mapItemClass = [MKMapItem class];
	if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
		NSString *latitute = [self.cinemaToShow objectAtIndex:3];
		NSString *longitude = [self.cinemaToShow objectAtIndex:4];
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitute.doubleValue, longitude.doubleValue);
		MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
													   addressDictionary:nil];
		MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
		[mapItem setName:self.movieToShow.cinema];
		
		// Set the directions mode to "Walking"
		// Can use MKLaunchOptionsDirectionsModeDriving instead
		NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
		// Get the "Current User Location" MKMapItem
		MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
		// Pass the current location and destination map items to the Maps app
		// Set the direction mode in the launchOptions dictionary
		[MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
					   launchOptions:launchOptions];
	}
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
