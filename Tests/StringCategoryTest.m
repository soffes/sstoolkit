//
//  StringCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SSToolkit/NSString+SSToolkitAdditions.h>

@interface StringCategoryTest : GHTestCase
@end

@implementation StringCategoryTest

// To test:
//+ (NSString *)localizedString:(NSString*)key;
//- (NSString *)escapeHTML;
//- (NSString *)unescapeHTML;
//- (NSString *)URLEncodedString;
//- (NSString *)URLEncodedParameterString;
//- (NSString *)URLDecodedString;
//- (NSString *)removeQuotes;
//- (NSString *)stringByEscapingForURLQuery;
//- (NSString *)stringByUnescapingFromURLQuery;
//- (NSString *)base64EncodedString;

- (void)testContainsString {
	NSString *string = @"alexanderthegreat";
	
	GHAssertTrue([string containsString:@"alex"], nil);
	GHAssertFalse([string containsString:@"awesome"], nil);
}


- (void)testMD5Sum {
	GHAssertEqualObjects([@"sam" MD5Sum], @"332532dcfaa1cbf61e2a266bd723612c", nil);
	
	NSString *lorem = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	GHAssertEqualObjects([lorem MD5Sum], @"fa5c89f3c88b81bfd5e821b0316569af", nil);
}


- (void)testSHA1Sum {
	GHAssertEqualObjects([@"sam" SHA1Sum], @"f16bed56189e249fe4ca8ed10a1ecae60e8ceac0", nil);
	
	NSString *lorem = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	GHAssertEqualObjects([lorem SHA1Sum], @"19afa2a4a37462c7b940a6c4c61363d49c3a35f4", nil);
}


- (void)testCompareToVersionString {
	GHAssertEquals([@"1.0.0" compareToVersionString:@"0.0.1"], NSOrderedDescending, nil);
	GHAssertEquals([@"3.2" compareToVersionString:@"4.2"], NSOrderedAscending, nil);
	GHAssertEquals([@"3.2.1" compareToVersionString:@"4.2.1"], NSOrderedAscending, nil);
}

@end
