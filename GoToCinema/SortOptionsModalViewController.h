//
//  SortOptionsModalViewController.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 10.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoviesViewController;

@interface SortOptionsModalViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) MoviesViewController *moviesControlller;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
