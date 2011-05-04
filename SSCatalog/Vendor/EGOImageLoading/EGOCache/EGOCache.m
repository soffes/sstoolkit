//
//  EGOCache.m
//  enormego
//
//  Created by Shaun Harrison on 7/4/09.
//  Copyright 2009 enormego. All rights reserved.
//
//  This work is licensed under the Creative Commons GNU General Public License License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/GPL/2.0/
//  or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA.
//

#import "EGOCache.h"

#if DEBUG
	#define CHECK_FOR_EGOCACHE_PLIST() if([key isEqualToString:@"EGOCache.plist"]) { \
		NSLog(@"EGOCache.plist is a reserved key and can not be modified."); \
		return; }
#else
	#define CHECK_FOR_EGOCACHE_PLIST() if([key isEqualToString:@"EGOCache.plist"]) return;
#endif



static NSString* _EGOCacheDirectory;

static inline NSString* EGOCacheDirectory() {
	if(!_EGOCacheDirectory) {
#ifdef TARGET_OS_IPHONE
		_EGOCacheDirectory = [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/EGOCache"] copy];
#else
		NSString* appSupportDir = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		_EGOCacheDirectory = [[[appSupportDir stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"EGOCache"] copy];
#endif
	}
	
	return _EGOCacheDirectory;
}

static inline NSString* cachePathForKey(NSString* key) {
	return [EGOCacheDirectory() stringByAppendingPathComponent:key];
}

static EGOCache* __instance;

@interface EGOCache ()
- (void)removeItemFromCache:(NSString*)key;
- (void)performDiskWriteOperation:(NSInvocation *)invoction;
- (void)saveCacheDictionary;
@end

#pragma mark -

@implementation EGOCache
@synthesize defaultTimeoutInterval;

+ (EGOCache*)currentCache {
	@synchronized(self) {
		if(!__instance) {
			__instance = [[EGOCache alloc] init];
			__instance.defaultTimeoutInterval = 86400;
		}
	}
	
	return __instance;
}

- (id)init {
	if((self = [super init])) {
		NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:cachePathForKey(@"EGOCache.plist")];
		
		if([dict isKindOfClass:[NSDictionary class]]) {
			cacheDictionary = [dict mutableCopy];
		} else {
			cacheDictionary = [[NSMutableDictionary alloc] init];
		}
		
		diskOperationQueue = [[NSOperationQueue alloc] init];
		
		[[NSFileManager defaultManager] createDirectoryAtPath:EGOCacheDirectory() 
								  withIntermediateDirectories:YES 
												   attributes:nil 
														error:NULL];
		
		for(NSString* key in cacheDictionary) {
			NSDate* date = [cacheDictionary objectForKey:key];
			if([[[NSDate date] earlierDate:date] isEqualToDate:date]) {
				[[NSFileManager defaultManager] removeItemAtPath:cachePathForKey(key) error:NULL];
			}
		}
	}
	
	return self;
}

- (void)clearCache {
	for(NSString* key in [cacheDictionary allKeys]) {
		[self removeItemFromCache:key];
	}
	
	[self saveCacheDictionary];
}

- (void)removeCacheForKey:(NSString*)key {
	CHECK_FOR_EGOCACHE_PLIST();

	[self removeItemFromCache:key];
	[self saveCacheDictionary];
}

- (void)removeItemFromCache:(NSString*)key {
	NSString* cachePath = cachePathForKey(key);
	
	NSInvocation* deleteInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(deleteDataAtPath:)]];
	[deleteInvocation setTarget:self];
	[deleteInvocation setSelector:@selector(deleteDataAtPath:)];
	[deleteInvocation setArgument:&cachePath atIndex:2];
	
	[self performDiskWriteOperation:deleteInvocation];
	[cacheDictionary removeObjectForKey:key];
}

- (BOOL)hasCacheForKey:(NSString*)key {
	NSDate* date = [cacheDictionary objectForKey:key];
	if(!date) return NO;
	if([[[NSDate date] earlierDate:date] isEqualToDate:date]) return NO;
	return [[NSFileManager defaultManager] fileExistsAtPath:cachePathForKey(key)];
}

#pragma mark -
#pragma mark Data methods

- (void)setData:(NSData*)data forKey:(NSString*)key {
	[self setData:data forKey:key withTimeoutInterval:self.defaultTimeoutInterval];
}

- (void)setData:(NSData*)data forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	CHECK_FOR_EGOCACHE_PLIST();
	
	NSString* cachePath = cachePathForKey(key);
	NSInvocation* writeInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(writeData:toPath:)]];
	[writeInvocation setTarget:self];
	[writeInvocation setSelector:@selector(writeData:toPath:)];
	[writeInvocation setArgument:&data atIndex:2];
	[writeInvocation setArgument:&cachePath atIndex:3];
	
	[self performDiskWriteOperation:writeInvocation];
	[cacheDictionary setObject:[NSDate dateWithTimeIntervalSinceNow:timeoutInterval] forKey:key];
	
	[self performSelectorOnMainThread:@selector(saveAfterDelay) withObject:nil waitUntilDone:YES]; // Need to make sure the save delay get scheduled in the main runloop, not the current threads
}

- (void)saveAfterDelay { // Prevents multiple-rapid saves from happening, which will slow down your app
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(saveCacheDictionary) object:nil];
	[self performSelector:@selector(saveCacheDictionary) withObject:nil afterDelay:0.3];
}

- (NSData*)dataForKey:(NSString*)key {
	if([self hasCacheForKey:key]) {
		return [NSData dataWithContentsOfFile:cachePathForKey(key) options:0 error:NULL];
	} else {
		return nil;
	}
}

- (void)writeData:(NSData*)data toPath:(NSString *)path; {
	[data writeToFile:path atomically:YES];
} 

- (void)deleteDataAtPath:(NSString *)path {
	[[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

- (void)saveCacheDictionary {
	@synchronized(self) {
		[cacheDictionary writeToFile:cachePathForKey(@"EGOCache.plist") atomically:YES];
	}
}

#pragma mark -
#pragma mark String methods

- (NSString*)stringForKey:(NSString*)key {
	return [[[NSString alloc] initWithData:[self dataForKey:key] encoding:NSUTF8StringEncoding] autorelease];
}

- (void)setString:(NSString*)aString forKey:(NSString*)key {
	[self setString:aString forKey:key withTimeoutInterval:self.defaultTimeoutInterval];
}

- (void)setString:(NSString*)aString forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:[aString dataUsingEncoding:NSUTF8StringEncoding] forKey:key withTimeoutInterval:timeoutInterval];
}

#pragma mark -
#pragma mark Image methds

#if TARGET_OS_IPHONE

- (UIImage*)imageForKey:(NSString*)key {
	return [UIImage imageWithData:[self dataForKey:key]];
}

- (void)setImage:(UIImage*)anImage forKey:(NSString*)key {
	[self setImage:anImage forKey:key withTimeoutInterval:self.defaultTimeoutInterval];
}

- (void)setImage:(UIImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:UIImagePNGRepresentation(anImage) forKey:key withTimeoutInterval:timeoutInterval];
}


#else

- (NSImage*)imageForKey:(NSString*)key {
	return [[[NSImage alloc] initWithData:[self dataForKey:key]] autorelease];
}

- (void)setImage:(NSImage*)anImage forKey:(NSString*)key {
	[self setImage:anImage forKey:key withTimeoutInterval:self.defaultTimeoutInterval];
}

- (void)setImage:(NSImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:[[[anImage representations] objectAtIndex:0] representationUsingType:NSPNGFileType properties:nil]
		   forKey:key withTimeoutInterval:timeoutInterval];
}

#endif

#pragma mark -
#pragma mark Property List methods

- (NSData*)plistForKey:(NSString*)key; {  
	NSData* plistData = [self dataForKey:key];
	
	return [NSPropertyListSerialization propertyListFromData:plistData
											mutabilityOption:NSPropertyListImmutable
													  format:nil
											errorDescription:nil];
}

- (void)setPlist:(id)plistObject forKey:(NSString*)key; {
	[self setPlist:plistObject forKey:key withTimeoutInterval:self.defaultTimeoutInterval];
}

- (void)setPlist:(id)plistObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval; {
	// Binary plists are used over XML for better performance
	NSData* plistData = [NSPropertyListSerialization dataFromPropertyList:plistObject 
																   format:NSPropertyListBinaryFormat_v1_0
														 errorDescription:NULL];
	
	[self setData:plistData forKey:key withTimeoutInterval:timeoutInterval];
}

#pragma mark -
#pragma mark Disk writing operations

- (void)performDiskWriteOperation:(NSInvocation *)invoction {
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invoction];
	[diskOperationQueue addOperation:operation];
	[operation release];
}

#pragma mark -

- (void)dealloc {
	[diskOperationQueue release];
	[cacheDictionary release];
	[super dealloc];
}

@end