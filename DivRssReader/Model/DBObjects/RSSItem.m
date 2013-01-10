//
//  RSSItem.m
//  DivRssReader
//
//  Created by Artem Kislitsyn on 09.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import "RSSItem.h"


@implementation RSSItem

@dynamic title;
@dynamic link;
@dynamic descript;
@dynamic pubDate;

+(RSSItem*)createRSSObjectFromXmlItem:(GDataXMLElement*)xmlItem{
    
    
    RSSItem * item=nil;
    
    if (!item) {
        item =( RSSItem *)[[DivRssDataSource sharedClient] createNew:@"RSSItem"];
    }
    
    item.title=[[[xmlItem elementsForName:@"title"] objectAtIndex:0] stringValue];
    item.link=[[[xmlItem elementsForName:@"link"] objectAtIndex:0] stringValue];
    item.descript=[[[xmlItem elementsForName:@"description"] objectAtIndex:0] stringValue];
    item.pubDate=[[[xmlItem elementsForName:@"pubDate"] objectAtIndex:0] stringValue];
    
    return item;
}
@end