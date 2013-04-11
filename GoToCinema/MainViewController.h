//
//  MainViewController.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 09.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *currentLocation;

@property (strong, nonatomic) NSArray *rawData;

- (IBAction)seeMovies:(UIButton *)button;
- (IBAction)setTimeAndLocation:(UIButton *)button;


@end
