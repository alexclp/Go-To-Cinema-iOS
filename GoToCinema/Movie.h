//
//  Movie.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 09.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSString *englishTitle;
@property (strong, nonatomic) NSString *romanianTitle;
@property (strong, nonatomic) NSString *cinema;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *genre;
@property (strong, nonatomic) NSString *cast;
@property (strong, nonatomic) NSString *director;

@end
