//
//  DivRssDataSource.m
//  DivRssReader
//
//  Created by Artem Kislitsyn on 08.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import "DivRssDataSource.h"

@implementation DivRssDataSource

+ (id)sharedClient
{
    static dispatch_once_t pred = 0;
    __strong static id __dataSource = nil;
    
    dispatch_once(&pred, ^{
        __dataSource=[[self alloc]init];
    
        
    });
    
    return __dataSource;
}

@end
