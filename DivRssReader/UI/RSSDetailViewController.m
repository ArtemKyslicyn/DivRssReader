//
//  RSSDetailViewController.m
//  DivRssReader
//
//  Created by Artem Kislitsyn on 10.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import "RSSDetailViewController.h"
#import "MBProgressHUD.h"
#import "RNCachingURLProtocol.h"
@interface RSSDetailViewController ()

@end

@implementation RSSDetailViewController
@synthesize urlString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
  
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
     [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
     [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}
-(void)viewWillAppear:(BOOL)animated{
  
   NSLog(@"%@",urlString);
  // [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0]];
  [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]]];
  [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
  [super viewWillAppear:animated];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
