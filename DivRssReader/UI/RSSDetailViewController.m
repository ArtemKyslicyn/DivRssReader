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
  /*   NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    [[NSFileManager defaultManager]
     createFileAtPath:[self cacheFile] contents:data attributes:nil];*/
}

-(NSString*)cacheFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask, YES);
    NSString * diskPath=[NSString stringWithFormat:@"%@",urlString];
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:diskPath];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    
    NSData *data = [NSData dataWithContentsOfFile:[self cacheFile]
                                          options:NSDataReadingMappedAlways error:nil];
    
    [webView loadData:data MIMEType:@"text/html"
     textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:urlString]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}
-(void)viewWillAppear:(BOOL)animated{
  
   NSLog(@"%@",urlString);
  
  [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString: urlString /*@"http://www.apple.com"*/]]];
  [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
  [super viewWillAppear:animated];
    
	
   /* NSData *data = [NSData dataWithContentsOfFile:[self cacheFile]
                                          options:NSDataReadingMappedAlways error:nil];
    
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",myString);*/
    

   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
