//
//  SearchUsersViewController.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 04.06.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchUsersViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *searchResult;
@property (strong, nonatomic) NSArray *usersArray;

@end
