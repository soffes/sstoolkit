//
//  SSRateLimit.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/9/12.
//  Copyright (c) 2012 Sam Soffes. All rights reserved.
//

#import "SSRateLimit.h"

@interface SSRateLimit ()
+ (NSMutableDictionary *)_dictionary;
@end

@implementation SSRateLimit

+ (BOOL)executeBlock:(void(^)(void))block name:(NSString *)name limit:(NSTimeInterval)limit {
	// Prevent a nil block
	if (!block) {
		return NO;
	}
	
	// Lookup last executed
	NSMutableDictionary *dictionary = [self _dictionary];	
	NSDate *last = [dictionary objectForKey:name];
	NSTimeInterval timeInterval = [last timeIntervalSinceNow];
	
	// If last excuted is less than the limit, don't execute
	if (timeInterval < 0 && fabs(timeInterval) < limit) {
		return NO;
	}
	
	// Execute
	block();
	[dictionary setObject:[NSDate date] forKey:name];
	return YES;
}


+ (void)resetLimitForName:(NSString *)name {
	[[self _dictionary] removeObjectForKey:name];
}


#pragma mark - Private

+ (NSMutableDictionary *)_dictionary {
	static NSMutableDictionary *dictionary = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dictionary = [[NSMutableDictionary alloc] init];
	});
	return dictionary;
}

@end
