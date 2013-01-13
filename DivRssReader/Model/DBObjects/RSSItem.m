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
@dynamic orderNumber;

+(RSSItem*)createRSSObjectFromXmlItem:(GDataXMLElement*)xmlItem{
    //Take data from xml item
    RSSItem * item =( RSSItem *)[[DivRssDataSource sharedClient] createNew:@"RSSItem"];
    item.title=[[[xmlItem elementsForName:@"title"] objectAtIndex:0] stringValue];
    item.link=[[[xmlItem elementsForName:@"link"] objectAtIndex:0] stringValue];
    item.descript=[[[xmlItem elementsForName:@"description"] objectAtIndex:0] stringValue];
    item.pubDate=[[[xmlItem elementsForName:@"pubDate"] objectAtIndex:0] stringValue];
    
    return item;
}

-(float)cellHeight{
    //CELL HEIGHT
    return [self titleHeight]+[self descriptHeight]+[self pubDateHeight]+CELL_OFFSET;
}

-(float)titleHeight{
     //Calculated height from text for title
    return [self.title sizeWithFont:[UIFont boldSystemFontOfSize:TITLE_FONT] constrainedToSize:CGSizeMake(CONTENT_WIDTH, 9999) lineBreakMode:UILineBreakModeWordWrap].height;
}
-(float)descriptHeight{
    //Calculated height from text for description
    return [self.descript sizeWithFont:[UIFont systemFontOfSize:DESCR_FONT] constrainedToSize:CGSizeMake(CONTENT_WIDTH, 9999) lineBreakMode:UILineBreakModeWordWrap].height;
}

-(float)pubDateHeight{
     //Calculated height from text for date
    return [self.pubDate sizeWithFont:[UIFont systemFontOfSize:DATE_FONT] constrainedToSize:CGSizeMake(CONTENT_WIDTH, 9999) lineBreakMode:UILineBreakModeWordWrap].height;
}
@end
