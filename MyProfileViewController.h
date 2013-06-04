//
//  MyProfileViewController.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 05.06.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirth;
@property (weak, nonatomic) IBOutlet UITableView *posts;

@property (strong, nonatomic) NSDictionary *wallInfo;
@property (strong, nonatomic) NSArray *wallPosts;

@end
