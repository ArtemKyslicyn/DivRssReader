//
//  Config.h
//  DivRssReader
//
//  Created by Artem Kislitsyn on 08.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#define PARSE_ERROR @"parsing error"
#define DBNAME @"DivRss"
#define CELL_OFFSET 15
#define CONTENT_WIDTH 265
#define TITLE_FONT  17
#define DATE_FONT   12
#define DESCR_FONT  13
#define SERVER_BASE_URL @"http://developer.apple.com/"
#define RSS_URL @"news/rss/news.rss"
#define APPLICATION_DOCUMENTS_DIRECTORY [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APPLICATION_CACHE_DIRECTORY [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define WEB_CACHE_PATH [APPLICATION_CACHE_DIRECTORY stringByAppendingPathComponent:@"WebCache"]

#define APPLICATION_FRAME [[UIScreen mainScreen] bounds]

#define SETTINGS_ROOT_PLIST_PATH [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"]] pathForResource:@"Root" ofType:@"plist"]


#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define res(string) NSLocalizedString(string, @"")
#define XAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])