//
//  WallViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 04.06.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "WallViewController.h"
#import "AFHTTPClient.h"
#import "UIImageView+AFNetworking.h"

@interface WallViewController ()

@end

@implementation WallViewController

@synthesize wallInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	self.dateOfBirth.text = [self.wallInfo objectForKey:@"DOB"];
	[self.profilePic setImageWithURL:[NSURL URLWithString:[self.wallInfo objectForKey:@"image"]]];
	self.username.text = [self.wallInfo objectForKey:@"fullname"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
