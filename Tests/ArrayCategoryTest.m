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
	
	array = [[NSArray alloc] init];
	GHAssertNil([array firstObject], nil);
	[array release];
}


- (void)testMD5Sum {
	NSArray *array1 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", nil];
	[array2 addObject:@"value5"];
		
	NSString *sum1 = [array1 MD5Sum];
	NSString *sum2 = [array2 MD5Sum];
	GHAssertNotNil(sum1, nil);
	GHAssertNotNil(sum2, nil);
	GHAssertEqualObjects(sum1, sum2, nil);
}


- (void)testSHA1Sum {
	NSArray *array1 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", nil];
	[array2 addObject:@"value5"];
	
	NSString *sum1 = [array1 SHA1Sum];
	NSString *sum2 = [array2 SHA1Sum];
	GHAssertNotNil(sum1, nil);
	GHAssertNotNil(sum2, nil);
	GHAssertEqualObjects(sum1, sum2, nil);
}

@end
