//
//  NSDictionary+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 9/21/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "NSDictionary+SSToolkitAdditions.h"
#import "NSString+SSToolkitAdditions.h"
#import "NSData+SSToolkitAdditions.h"

@interface NSDictionary (SSToolkitPrivateAdditions)
- (NSData *)_prehashData;
@end

@implementation NSDictionary (SSToolkitAdditions)

+ (NSDictionary *)dictionaryWithFormEncodedString:(NSString *)encodedString {
	if (!encodedString) {
		return nil;
	}
	
	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	NSArray *pairs = [encodedString componentsSeparatedByString:@"&"];
	
	for (NSString *kvp in pairs) {
		if ([kvp length] == 0) {
			continue;
		}
		
		NSRange pos = [kvp rangeOfString:@"="];
		NSString *key;
		NSString *val;
		
		if (pos.location == NSNotFound) {
			key = [kvp stringByUnescapingFromURLQuery];
			val = @"";
		} else {
			key = [[kvp substringToIndex:pos.location] stringByUnescapingFromURLQuery];
			val = [[kvp substringFromIndex:pos.location + pos.length] stringByUnescapingFromURLQuery];
		}
		
		if (!key || !val) {
			continue; // I'm sure this will bite my arse one day
		}
		
		[result setObject:val forKey:key];
	}
	return result;
}


- (NSString *)stringWithFormEncodedComponents {
	NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:[self count]];
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
		[arguments addObject:[NSString stringWithFormat:@"%@=%@",
							  [key stringByEscapingForURLQuery],
							  [[object description] stringByEscapingForURLQuery]]];
	}];
	
	return [arguments componentsJoinedByString:@"&"];
}


- (NSMutableDictionary *)deepMutableCopy {
	return (__bridge_transfer NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFDictionaryRef)self, kCFPropertyListMutableContainers);
}


- (NSString *)MD5Sum {
	return [[self _prehashData] MD5Sum];
}


- (NSString *)SHA1Sum {
	return [[self _prehashData] SHA1Sum];
}


- (id)safeObjectForKey:(id)key {
	id value = [self valueForKey:key];
	if (value == [NSNull null]) {
		return nil;
	}
	return value;
}

@end


@implementation NSDictionary (SSToolkitPrivateAdditions)

- (NSData *)_prehashData {
	return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
}

@end
