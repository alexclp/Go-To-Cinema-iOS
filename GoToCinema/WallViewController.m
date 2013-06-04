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
#import "WallCustomCell.h"

@interface WallViewController ()

@end

@implementation WallViewController

@synthesize wallInfo;
@synthesize wallPosts;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.wallPosts.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.posts deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"Wall Cell";
	
	WallCustomCell *cell = [self.posts dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = (WallCustomCell *)[WallCustomCell cellFromNibNamed:@"WallCustomCell"];
	}
	NSDictionary *individualPost = [self.wallPosts objectAtIndex:indexPath.row];
	NSDictionary *sender = [individualPost objectForKey:@"sender"];
	cell.postTitle.text = [individualPost objectForKey:@"title"];
	cell.username.text = [sender objectForKey:@"fullname"];
	[cell.profilePic setImageWithURL:[NSURL URLWithString:[sender objectForKey:@"image"]]];
	
	return cell;
}

#pragma mark user interaction

- (void)postToUserWall:(UIButton *)button
{
	
}

#pragma mark view methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	self.title = @"Wall";
	
	
	NSLog(@"wall = %@", self.wallInfo);
	
	self.dateOfBirth.text = [self.wallInfo objectForKey:@"DOB"];
	[self.profilePic setImageWithURL:[NSURL URLWithString:[self.wallInfo objectForKey:@"image"]]];
	self.username.text = [self.wallInfo objectForKey:@"fullname"];
	
	self.wallPosts = [[NSArray alloc] initWithArray:[self.wallInfo objectForKey:@"wall_posts"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
