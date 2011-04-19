//
//  ArrayCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/NSArray+SSToolkitAdditions.h>

@interface ArrayCategoryTest : GHTestCase
@end

@implementation ArrayCategoryTest

// To test:
//- (id)randomObject;
//- (NSArray *)shuffledArray;

- (void)testFirstObject {
	NSArray *array = [[NSArray alloc] initWithObjects:@"foo", @"bar", nil];
	GHAssertEqualObjects([array firstObject], @"foo", nil);
	[array release];
}

@end
