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

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *descript;
@property (nonatomic, retain) NSString *pubDate;
/*
 @discussion property for sorting objects in coredata when working ofline
 */
@property (nonatomic, retain) NSNumber *orderNumber;
/*
 @discussion create object method from xml item
 @param xmlItem
 @result CoreDate Item RSSItem
 */
+ (RSSItem *)createRSSObjectFromXmlItem:(GDataXMLElement *)xmlItem;
/*
 @discussion calclculate heght label for title
 @result height in float
 */
- (float)titleHeight;
/*
 @discussion calclculate heght label for description
 @result height in float
 */
- (float)descriptHeight;
/*
 @discussion calclculate heght label for date
 @result height in float
 */
- (float)pubDateHeight;
/*
 @discussion calclculate summary heght cell
 @result summary height in float
 */
- (float)cellHeight;

@end
