//
//  MoviesViewController.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 10.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *arrayToShow;
@property (strong, nonatomic) NSDictionary *cinemaLocation;
@property (strong, nonatomic) NSArray *rawData;
@property (strong, nonatomic) NSDictionary *keyValue;
@property (strong, nonatomic) NSArray *arrayOfSeconds;

@end
