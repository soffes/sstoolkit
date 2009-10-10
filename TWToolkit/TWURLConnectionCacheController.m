//
//  TWURLConnectionCacheController.m
//  TWToolkit
//
//  Created by Sam Soffes on 10/10/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnectionCacheController.h"

#define kTWURLConnectionCacheDefaultsKey @"_TWURLConnectionCache"

@implementation TWURLConnectionCacheController

+ (void)clearAllCaches {
	NSDictionary *cachesDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kTWURLConnectionCacheDefaultsKey];
	
	for (NSString *hash in cachesDictionary) {
		[self removeCacheWithHash:hash];
	}	
}

+ (void)removeInvalidCaches {
	NSDictionary *cachesDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kTWURLConnectionCacheDefaultsKey];
	
	for (NSString *hash in cachesDictionary) {
		if ([self cacheIsValid:[cachesDictionary objectForKey:hash]] == NO) {
			[self removeCacheWithHash:hash];
		}
	}	
}

+ (void)cacheRequest:(TWURLRequest *)request withData:(NSData *)data {
	// TODO: Write to disk
}

+ (id)cachedObjectWithHash:(NSString *)hash {
	// TODO: Unarchive data
	return nil;
}

+ (void)removeCacheWithHash:(NSString *)hash {
	[[NSFileManager defaultManager] removeItemAtPath:[self pathForCacheWithHash:hash] error:nil];
}

+ (NSString *)pathForCacheWithHash:(NSString *)hash {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachesDirectory = [paths objectAtIndex:0];
	return [NSString stringWithFormat:@"%@/TWToolkit/TWURLConnectionCache/%@", cachesDirectory, hash];
}

+ (BOOL)cacheIsValid:(NSDictionary *)cacheInfo {
	// TODO: check info
	return NO;
}

+ (NSDictionary *)cacheInfoWithHash:(NSString *)hash {
	return [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kTWURLConnectionCacheDefaultsKey] objectForKey:hash];
}

@end
