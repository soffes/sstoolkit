//
//  DataCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/NSData+SSToolkitAdditions.h>

@interface DataCategoryTest : GHTestCase
@end

@implementation DataCategoryTest

- (void)testMD5Sum {
	NSData *data = [@"sam" dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects([data MD5Sum], @"332532dcfaa1cbf61e2a266bd723612c", nil);
	
	NSString *lorem = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	data = [lorem dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects([data MD5Sum], @"fa5c89f3c88b81bfd5e821b0316569af", nil);
}

@end
