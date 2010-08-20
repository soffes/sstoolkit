//
//  NSArray+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009 Sam Soffes. All rights reserved.
//

#import "NSArray+SSToolkitAdditions.h"

@implementation NSArray (SSToolkitAdditions)

- (NSArray *)shuffledArray {
	
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	
	NSMutableArray *copy = [self mutableCopy];
	while ([copy count] > 0) {
		int index = arc4random() % [copy count];
		id objectToMove = [copy objectAtIndex:index];
		[array addObject:objectToMove];
		[copy removeObjectAtIndex:index];
	}
	
	[copy release];
	return array;
}

@end
