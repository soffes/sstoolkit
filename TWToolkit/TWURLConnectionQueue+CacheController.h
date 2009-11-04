//
//  TWURLConnectionQueue+CacheController.h
//  TWToolkit
//
//  Created by Sam Soffes on 10/10/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLConnectionQueue.h"

@class TWURLRequest;

@interface TWURLConnectionQueue (CacheController)

+ (void)clearAllCaches;
+ (void)removeInvalidCaches;
+ (void)cacheRequest:(TWURLRequest *)request withData:(NSData *)data;
+ (id)cachedObjectWithHash:(NSString *)hash;
+ (void)removeCacheWithHash:(NSString *)hash;
+ (NSString *)pathForCacheWithHash:(NSString *)hash;
+ (BOOL)cacheIsValid:(NSDictionary *)cacheInfo;
+ (NSDictionary *)cacheInfoWithHash:(NSString *)hash;

@end
