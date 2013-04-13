//
//  DetailMovieViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 13.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "DetailMovieViewController.h"
#import "Movie.h"

@interface DetailMovieViewController ()

@end

@implementation DetailMovieViewController

@synthesize ratingLabel;
@synthesize genreLabel;
@synthesize castLabel;
@synthesize directorLabel;
@synthesize movieToShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	self.title = self.movieToShow.englishTitle;
	self.ratingLabel.text = self.movieToShow.rating;
	self.genreLabel.text = self.movieToShow.genre;
	self.castLabel.text = self.movieToShow.cast;
	self.directorLabel.text = self.movieToShow.director;
	
	[super viewWillAppear:animated];
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
