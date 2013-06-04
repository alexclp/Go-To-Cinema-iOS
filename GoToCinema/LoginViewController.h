//
//  LoginViewController.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 10.05.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *user;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)login:(UIButton *)button;

@end
