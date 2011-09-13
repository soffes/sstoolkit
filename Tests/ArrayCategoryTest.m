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


- (void)testMD5Sum {
	NSArray *array1 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	NSArray *array2 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
		
	GHAssertEqualObjects([array1 MD5Sum], [array2 MD5Sum], nil);
}


- (void)testSHA1Sum {
	NSArray *array1 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	NSArray *array2 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	
	GHAssertEqualObjects([array1 SHA1Sum], [array2 SHA1Sum], nil);
}

@end
