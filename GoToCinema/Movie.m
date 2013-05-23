//
//  Movie.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 09.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "Movie.h"

@implementation Movie

@synthesize englishTitle;
@synthesize romanianTitle;
@synthesize cinema;
@synthesize time;
@synthesize rating;
@synthesize genre;
@synthesize cast;
@synthesize director;
@synthesize movieID;
@synthesize imageLink;

+ (Movie *)movieWithCast:(NSString *)cast genre:(NSString *)genre movieID:(NSString *)movieid image:(NSString *)link director:(NSString *)dir englishTitle:(NSString *)en romanianTitle:(NSString *)ro
{
	Movie *movie = [[Movie alloc] init];
	movie.cast = cast;
	movie.genre = genre;
	movie.movieID = movieid;
	movie.imageLink = link;
	movie.director = dir;
	movie.englishTitle = en;
	movie.romanianTitle = ro;
	return movie;
}

@end
