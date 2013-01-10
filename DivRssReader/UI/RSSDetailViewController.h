//
//  RSSDetailViewController.h
//  DivRssReader
//
//  Created by Artem Kislitsyn on 10.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(nonatomic,retain) NSString * urlString;
@end
