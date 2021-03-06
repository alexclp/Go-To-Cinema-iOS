//
//  WallCustomCell.h
//  GoToCinema
//
//  Created by Alexandru Clapa on 04.06.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "CustomCellWallSuper.h"

@interface WallCustomCell : CustomCellWallSuper

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *postTitle;

@end
