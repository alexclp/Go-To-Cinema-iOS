//
//  MyProfileViewController.m
//  GoToCinema
//
//  Created by Alexandru Clapa on 05.06.2013.
//  Copyright (c) 2013 Alexandru Clapa. All rights reserved.
//

#import "MyProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPClient.h"
#import "WallCustomCell.h"
#import "AFJSONRequestOperation.h"


@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

@synthesize profilePic;
@synthesize username;
@synthesize dateOfBirth;
@synthesize posts;
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

- (NSString *)getUserID
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
	NSDictionary *loginData = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	
	return [loginData objectForKey:@"user_id"];
}

- (void)getData
{
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://cinemadistance.eu01.aws.af.cm/user/%@/wall", [self getUserID]]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
		self.wallInfo = [[NSDictionary alloc] initWithDictionary:(NSDictionary *)JSON];
		self.wallPosts = [self.wallInfo objectForKey:@"wall_posts"];
		[self.posts reloadData];
		self.dateOfBirth.text = [self.wallInfo objectForKey:@"DOB"];
		[self.profilePic setImageWithURL:[NSURL URLWithString:[self.wallInfo objectForKey:@"image"]]];
		self.username.text = [self.wallInfo objectForKey:@"fullname"];
		NSLog(@"wall =%@", self.wallInfo);
	} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
		NSLog(@"fail with error = %@", error);
	}];
	[operation start];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	self.title = @"Profilul meu";
	
	[self getData];
	self.wallPosts = [self.wallInfo objectForKey:@"wall_posts"];
	
	NSLog(@"self.wall = %@", self.wallInfo);
	
	
	[self.posts reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
