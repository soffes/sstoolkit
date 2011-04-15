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

@end
