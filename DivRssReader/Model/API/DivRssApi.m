//
//  DivRssApi.m
//  DivRssReader
//
//  Created by Artem Kislitsyn on 08.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import "DivRssApi.h"
#import "GDataXMLNode.h"
#import "RSSItem.h"
@implementation DivRssApi

+ (DivRssApi *)sharedClient{
    static DivRssApi *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[DivRssApi alloc] initWithBaseURL:[NSURL URLWithString:SERVER_BASE_URL] ];
    });
    
    return _sharedClient;
}

-(void)getRSSsuccess:(void (^)(AFHTTPRequestOperation * operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    [self getPath:RSS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id xmlData) {
        NSMutableArray* rssItems;
        NSError * error=nil;
        GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
        
        if (doc != nil) {
           
            NSArray* items = [[doc rootElement] nodesForXPath:@"channel/item" error:&error];
             rssItems = [NSMutableArray arrayWithCapacity:[items count] ];
            
            for (GDataXMLElement* xmlItem in items) {
                
                [rssItems addObject: [RSSItem createRSSObjectFromXmlItem:xmlItem]];
            
            }
            
            
        } else {
           
            failure(nil,[NSError errorWithDomain:PARSE_ERROR code:-100 userInfo:nil]);
        }

    
        
        
    success(operation,rssItems);
        
    }failure:failure];
    
}

@end
