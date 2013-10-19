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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                 navigationType:(UIWebViewNavigationType)navigationType
{
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        //TODO: DO REFACTORING TO THIS!!!!
	dispatch_async(dispatch_get_main_queue(), ^{
	    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        
	    NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
	    if (html.length > 0) {
	        [html writeToFile:[self cachePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
		}
	});
}


- (NSString *)cachePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *fileName = [NSString stringWithFormat:@"%x.html", [urlString hash]];
	NSString *htmlFilePath = [documentsDirectory stringByAppendingPathComponent:/*@"file.html"*/ fileName];
	return htmlFilePath;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    
	NSData *data = [NSData dataWithContentsOfFile:[self cachePath]
	                                      options:NSDataReadingMappedAlways error:nil];
    
	[webView loadData:data
             MIMEType:@"text/html"
     textEncodingName:@"UTF-8"
              baseURL:[NSURL URLWithString:urlString]];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
        // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
	NSLog(@"%@", urlString);
    
	[self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString /*@"http://www.apple.com"*/]]];
	[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

@end
