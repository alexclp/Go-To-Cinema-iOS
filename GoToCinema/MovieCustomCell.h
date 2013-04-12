//
//  MovieCustomCell.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 10.04.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "CustomCellSuper.h"

@interface MovieCustomCell : CustomCellSuper

@property (weak, nonatomic) IBOutlet UILabel *englishNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *romanianNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cinemaLabel;

@end
