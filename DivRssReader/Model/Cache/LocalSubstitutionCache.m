//
//  LocalSubstitutionCache.m
//  LocalSubstitutionCache
//
//  Created by Matt Gallagher on 2010/09/06.
//  Copyright 2010 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "LocalSubstitutionCache.h"

@implementation LocalSubstitutionCache

- (NSDictionary *)substitutionPaths
{
	return
		[NSDictionary dictionaryWithObjectsAndKeys:
			@"fakeGlobalNavBG.png", @"http://images.apple.com/global/nav/images/globalnavbg.png",
		nil];
}

- (NSString *)mimeTypeForPath:(NSString *)originalPath
{
	//
	// Current code only substitutes PNG images
	//
	return @"image/png";	
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request
{
	//
	// Get the path for the request
	//
	NSString *pathString = [[request URL] absoluteString];
	
	//
	// See if we have a substitution file for this path
	//
	NSString *substitutionFileName = [[self substitutionPaths] objectForKey:pathString];
	if (!substitutionFileName)
	{
		//
		// No substitution file, return the default cache response
		//
		return [super cachedResponseForRequest:request];
	}
	
	//
	// If we've already created a cache entry for this path, then return it.
	//
	NSCachedURLResponse *cachedResponse = [cachedResponses objectForKey:pathString];
	if (cachedResponse)
	{
		return cachedResponse;
	}
	
	//
	// Get the path to the substitution file
	//
	NSString *substitutionFilePath =
		[[NSBundle mainBundle]
			pathForResource:[substitutionFileName stringByDeletingPathExtension]
			ofType:[substitutionFileName pathExtension]];
	NSAssert(substitutionFilePath, @"File %@ in substitutionPaths didn't exist", substitutionFileName);
	
	//
	// Load the data
	//
	NSData *data = [NSData dataWithContentsOfFile:substitutionFilePath];
	
	//
	// Create the cacheable response
	//
	NSURLResponse *response =
		[[NSURLResponse alloc]
			initWithURL:[request URL]
			MIMEType:[self mimeTypeForPath:pathString]
			expectedContentLength:[data length]
			textEncodingName:nil]
		;
	cachedResponse =
		[[NSCachedURLResponse alloc] initWithResponse:response data:data] ;
	
	//
	// Add it to our cache dictionary
	//
	if (!cachedResponses)
	{
		cachedResponses = [[NSMutableDictionary alloc] init];
	}
	[cachedResponses setObject:cachedResponse forKey:pathString];
	
	return cachedResponse;
}

- (void)removeCachedResponseForRequest:(NSURLRequest *)request
{
	//
	// Get the path for the request
	//
	NSString *pathString = [[request URL] path];
	if ([cachedResponses objectForKey:pathString])
	{
		[cachedResponses removeObjectForKey:pathString];
	}
	else
	{
		[super removeCachedResponseForRequest:request];
	}
}



@end
