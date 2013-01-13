//
//  DivRssDataSource.m
//  DivRssReader
//
//  Created by Artem Kislitsyn on 08.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import "DivRssDataSource.h"
#import "RSSItem.h"
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


- (RSSItem*) getRssItemForTitle:(NSString*)title  {
    
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title LIKE %@",title];
        NSArray *rssItems = [self getAllByName:@"RSSItem" predicate:predicate];
        return [rssItems lastObject];
    
}

-(NSArray*)getAllRss{
    
    NSArray *rssItems = [self getAllByName:@"RSSItem"];
    rssItems=[self  sortArray: rssItems byKey:@"orderNumber" ascending:YES];
    
    /*rssItems = [rssItems sortedArrayUsingComparator: ^(id a, id b) {
        
        RSSItem * itemA=a;
        RSSItem * itemB=b;
        
       NSDateFormatter *dateFormatA = [[NSDateFormatter alloc] init];
        //@"YYYY-MM-dd'T'HH:mm:ss'+0000'"
        [dateFormatA setDateFormat:@"EEEE, dd MM YYYY HH:mm:ss' PDT'"];
        NSDate *d1 = [dateFormatA dateFromString:itemA.pubDate];
        NSDate *d2 = [dateFormatA dateFromString:itemB.pubDate];
        
        return [d2 compare: d1];
    }];*/
    
    return rssItems;

}

@end
