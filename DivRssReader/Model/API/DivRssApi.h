//
//  DivRssApi.h
//  DivRssReader
//
//  Created by Artem Kislitsyn on 08.01.13.
//  Copyright (c) 2013 Artem Kislitsyn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPClient.h"

@interface DivRssApi : AFHTTPClient
/*
 @discussion rss singleton  method returned shared instance
 */
+ (DivRssApi *)sharedClient;

/*
 @discussion rss request metods
 @param success block for response parse xml core data objects
 @param fail block for response return erro of request
 */
- (void)getRSSsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
