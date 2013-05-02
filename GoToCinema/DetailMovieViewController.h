//
//  DetailMovieViewController.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 13.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class Movie;
@class Cinema;

@interface DetailMovieViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) Movie *movieToShow;
//@property (strong, nonatomic) Cinema *cinemaToShow;

@property (strong, nonatomic) NSArray *cinemaToShow;

@end
