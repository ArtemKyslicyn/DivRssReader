//
//  RssViewController.m
//  DivRssReader
//
//  Created by Artem Kislitsyn on 08.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import "RssViewController.h"
#import "RSSCell.h"
#import "RSSDetailViewController.h"

@interface RssViewController ()

@end

@implementation RssViewController

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
        // Do any additional setup after loading the view.
	[self getServerData];
}

- (void)getServerData
{
	[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	[[DivRssApi sharedClient] getRSSsuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    NSLog(@"%@", responseObject);
	    rssArray = responseObject;
	    [self.tableView reloadData];
	    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    rssArray = [[DivRssDataSource sharedClient] getAllRss];
	    [self.tableView reloadData];
	    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
	}];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [[rssArray objectAtIndex:indexPath.row] cellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        // Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        // Return the number of rows in the section.
	return [rssArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"RSSCell";
	RSSCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	RSSItem *item = [rssArray objectAtIndex:indexPath.row];
	[cell configureCellWithRssItem:item];
    
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RSSDetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
	RSSItem *item = [rssArray objectAtIndex:indexPath.row];
	detailViewController.urlString = item.link;
	[self.navigationController pushViewController:detailViewController animated:YES];
}

@end
