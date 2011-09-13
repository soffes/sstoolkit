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
	
	NSDictionary *dictionary2 = [NSDictionary dictionaryWithObjectsAndKeys:
								 @"value3", @"key3",
								 @"value4", @"key4",
								 @"value5", @"key5",
								 @"value2", @"key2",
								 @"value1", @"key1",
								 nil];
	
	GHAssertEqualObjects([dictionary1 MD5Sum], [dictionary2 MD5Sum], nil);
}


- (void)testSHA1Sum {
	NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:
								 @"value1", @"key1",
								 @"value2", @"key2",
								 @"value3", @"key3",
								 @"value4", @"key4",
								 @"value5", @"key5",
								 nil];
	
	NSDictionary *dictionary2 = [NSDictionary dictionaryWithObjectsAndKeys:
								 @"value3", @"key3",
								 @"value4", @"key4",
								 @"value5", @"key5",
								 @"value2", @"key2",
								 @"value1", @"key1",
								 nil];
	
	GHAssertEqualObjects([dictionary1 SHA1Sum], [dictionary2 SHA1Sum], nil);
}

@end
