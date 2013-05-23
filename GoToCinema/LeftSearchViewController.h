//
//  LeftSearchViewController.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 11.05.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftSearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
