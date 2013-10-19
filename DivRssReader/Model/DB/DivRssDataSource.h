//
//  DivRssDataSource.h
//  DivRssReader
//
//  Created by Artem Kislitsyn on 08.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"

@interface DivRssDataSource : DataSource
/*
 @discussion static singeton metod
 @result singletone instance
 */
+ (id)sharedClient;
/*
 @discussion static singeto metod
 @result return array of rss items from core data
 */
- (NSArray *)getAllRss;

@end
