//
//  NSArray+shuffle.m
//  TWToolkit
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "NSArray+shuffle.h"

@implementation NSArray (shuffle)

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
