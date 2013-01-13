//
//  RSSItem.h
//  DivRssReader
//
//  Created by Artem Kislitsyn on 09.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GDataXmlNode.h"

@interface RSSItem : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * descript;
@property (nonatomic, retain) NSString * pubDate;

+(RSSItem*)createRSSObjectFromXmlItem:(GDataXMLElement*)xmlItem;
-(float)titleHeight;
-(float)descriptHeight;
-(float)pubDateHeight;
-(float)cellHeight;
@end
