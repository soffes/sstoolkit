//
//  NSArray+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "NSArray+SSToolkitAdditions.h"

@implementation NSArray (SSToolkitAdditions)

- (id)firstObject {
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

@end
