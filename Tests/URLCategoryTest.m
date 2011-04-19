//
//  URLCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/NSURL+SSToolkitAdditions.h>

@interface URLCategoryTest : GHTestCase
@end

@implementation URLCategoryTest

- (void)testQueryDictionary {
	NSURL *url = [[NSURL alloc] initWithString:@"http://sstoolk.it/test?foo=bar&awesome=true"];
	NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
								@"bar", @"foo",
								@"true", @"awesome",
								nil];
	
	GHAssertEqualObjects([url queryDictionary], dictionary, nil);
	
	[url release];
	[dictionary release];
}

@end
