//
//  LoginViewController.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 10.05.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)login:(UIButton *)button;

@end