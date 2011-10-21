//
//  NSArray+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "NSArray+SSToolkitAdditions.h"
#import "NSData+SSToolkitAdditions.h"

@interface NSArray (SSToolkitPrivateAdditions)
- (NSData *)_prehashData;
@end

@implementation NSArray (SSToolkitAdditions)

- (id)firstObject {
	if ([self count] == 0) {
	    return nil;
	}

	return [self objectAtIndex:0];
}


- (id)randomObject {
	return [self objectAtIndex:arc4random() % [self count]];
}


- (NSArray *)shuffledArray {

	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];

	NSMutableArray *copy = [self mutableCopy];
	while ([copy count] > 0) {
		NSUInteger index = arc4random() % [copy count];
		id objectToMove = [copy objectAtIndex:index];
		[array addObject:objectToMove];
		[copy removeObjectAtIndex:index];
	}

	[copy release];
	return array;
}


- (NSString *)MD5Sum {
	return [[self _prehashData] MD5Sum];
}


- (NSString *)SHA1Sum {
	return [[self _prehashData] SHA1Sum];
}

@end


@implementation NSArray (SSToolkitPrivateAdditions)

- (NSData *)_prehashData {
	return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
}

@end
