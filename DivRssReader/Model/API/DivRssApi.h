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
+ (DivRssApi *)sharedClient;
-(void)getRSSsuccess:(void (^)(AFHTTPRequestOperation * operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
