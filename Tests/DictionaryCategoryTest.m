//
//  DictionaryCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/NSDictionary+SSToolkitAdditions.h>

@interface DictionaryCategoryTest : GHTestCase
@end

@implementation DictionaryCategoryTest

- (void)testURLEncoding {
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								@"value1", @"key1",
								@"value2", @"key2",
								nil];
	
	NSString *string = [dictionary stringWithFormEncodedComponents];
	GHAssertEqualObjects([NSDictionary dictionaryWithFormEncodedString:string], dictionary, nil);
	
	// Go nuts
	dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
				  @"£™¢£∞¢§∞¶•§ª¶º!@#$%^&*()", @"œ∑´∞®†¥¨ˆø",
				  @"ÎÍÏ˝ÓÔÒÚ˜Â¯", @"ç√≈∫˜µ≤∆˚¬˙©",
				  nil];
	
	string = [dictionary stringWithFormEncodedComponents];
	GHAssertEqualObjects([NSDictionary dictionaryWithFormEncodedString:string], dictionary, nil);
}


- (void)testMD5Sum {
	NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:
								 @"value1", @"key1",
								 @"value2", @"key2",
								 @"value3", @"key3",
								 @"value4", @"key4",
								 @"value5", @"key5",
								 nil];
	
	NSMutableDictionary *dictionary2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
										@"value3", @"key3",
										@"value4", @"key4",
										@"value5", @"key5",
										@"value1", @"key1",
										nil];
	[dictionary2 setObject:@"value2" forKey:@"key2"];
	
	NSString *sum1 = [dictionary1 MD5Sum];
	NSString *sum2 = [dictionary2 MD5Sum];
	GHAssertNotNil(sum1, nil);
	GHAssertNotNil(sum2, nil);
	GHAssertEqualObjects(sum1, sum2, nil);
}


- (void)testSHA1Sum {
	NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:
								 @"value1", @"key1",
								 @"value2", @"key2",
								 @"value3", @"key3",
								 @"value4", @"key4",
								 @"value5", @"key5",
								 nil];
	
	NSMutableDictionary *dictionary2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
										@"value3", @"key3",
										@"value4", @"key4",
										@"value5", @"key5",
										@"value1", @"key1",
										nil];
	[dictionary2 setObject:@"value2" forKey:@"key2"];
	
	NSString *sum1 = [dictionary1 SHA1Sum];
	NSString *sum2 = [dictionary2 SHA1Sum];
	GHAssertNotNil(sum1, nil);
	GHAssertNotNil(sum2, nil);
	GHAssertEqualObjects(sum1, sum2, nil);
}

@end
