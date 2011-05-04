//
//  EGOCache.h
//  enormego
//
//  Created by Shaun Harrison on 7/4/09.
//  Copyright 2009 enormego. All rights reserved.
//
//  This work is licensed under the Creative Commons GNU General Public License License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/GPL/2.0/
//  or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA.
//

#import <Foundation/Foundation.h>


@interface EGOCache : NSObject {
@private
	NSMutableDictionary* cacheDictionary;
	NSOperationQueue* diskOperationQueue;
	NSTimeInterval defaultTimeoutInterval;
}

+ (EGOCache*)currentCache;

- (void)clearCache;
- (void)removeCacheForKey:(NSString*)key;

- (BOOL)hasCacheForKey:(NSString*)key;

- (NSData*)dataForKey:(NSString*)key;
- (void)setData:(NSData*)data forKey:(NSString*)key; // withTimeoutInterval:defaultTimeoutInterval
- (void)setData:(NSData*)data forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSString*)stringForKey:(NSString*)key;
- (void)setString:(NSString*)aString forKey:(NSString*)key; // withTimeoutInterval:defaultTimeoutInterval
- (void)setString:(NSString*)aString forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

#if TARGET_OS_IPHONE
- (UIImage*)imageForKey:(NSString*)key;
- (void)setImage:(UIImage*)anImage forKey:(NSString*)key; // withTimeoutInterval:defaultTimeoutInterval
- (void)setImage:(UIImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;
#else
- (NSImage*)imageForKey:(NSString*)key;
- (void)setImage:(NSImage*)anImage forKey:(NSString*)key; // withTimeoutInterval:defaultTimeoutInterval
- (void)setImage:(NSImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;
#endif

- (NSData*)plistForKey:(NSString*)key;
- (void)setPlist:(id)plistObject forKey:(NSString*)key; // withTimeoutInterval:defaultTimeoutInterval
- (void)setPlist:(id)plistObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

@property(nonatomic,assign) NSTimeInterval defaultTimeoutInterval; // Default is 1 day
@end