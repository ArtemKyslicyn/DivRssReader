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

+ (id)sharedClient;
-(NSArray*)getAllRss;
@end
