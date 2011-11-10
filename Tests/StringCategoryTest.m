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
//- (NSString *)URLEncodedString;
//- (NSString *)URLEncodedParameterString;
//- (NSString *)URLDecodedString;

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
	
	GHAssertEquals([@"10.4" compareToVersionString:@"10.3"], NSOrderedDescending, nil);
	GHAssertEquals([@"10.5" compareToVersionString:@"10.5.0"], NSOrderedSame, nil);
	GHAssertEquals([@"10.4 Build 8L127" compareToVersionString:@"10.4 Build 8P135"], NSOrderedAscending, nil);
}


- (void)testBase64EncodedString {
	NSString *unencodedString = @"sam";
	NSString *encodedString = @"c2Ft";
	GHAssertEqualObjects(encodedString, [unencodedString base64EncodedString], nil);
	GHAssertEqualObjects(unencodedString, [NSString stringWithBase64String:encodedString], nil);
	
	unencodedString = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	encodedString = @"TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2ljaW5nIGVsaXQsIHNlZCBkbyBlaXVzbW9kIHRlbXBvciBpbmNpZGlkdW50IHV0IGxhYm9yZSBldCBkb2xvcmUgbWFnbmEgYWxpcXVhLiBVdCBlbmltIGFkIG1pbmltIHZlbmlhbSwgcXVpcyBub3N0cnVkIGV4ZXJjaXRhdGlvbiB1bGxhbWNvIGxhYm9yaXMgbmlzaSB1dCBhbGlxdWlwIGV4IGVhIGNvbW1vZG8gY29uc2VxdWF0LiBEdWlzIGF1dGUgaXJ1cmUgZG9sb3IgaW4gcmVwcmVoZW5kZXJpdCBpbiB2b2x1cHRhdGUgdmVsaXQgZXNzZSBjaWxsdW0gZG9sb3JlIGV1IGZ1Z2lhdCBudWxsYSBwYXJpYXR1ci4gRXhjZXB0ZXVyIHNpbnQgb2NjYWVjYXQgY3VwaWRhdGF0IG5vbiBwcm9pZGVudCwgc3VudCBpbiBjdWxwYSBxdWkgb2ZmaWNpYSBkZXNlcnVudCBtb2xsaXQgYW5pbSBpZCBlc3QgbGFib3J1bS4=";
	GHAssertEqualObjects(encodedString, [unencodedString base64EncodedString], nil);
	GHAssertEqualObjects(unencodedString, [NSString stringWithBase64String:encodedString], nil);
	
	unencodedString = @"http://www.cocoadev.com/index.pl?BaseSixtyFour";
	encodedString = @"aHR0cDovL3d3dy5jb2NvYWRldi5jb20vaW5kZXgucGw/QmFzZVNpeHR5Rm91cg==";
	GHAssertEqualObjects(encodedString, [unencodedString base64EncodedString], nil);
	GHAssertEqualObjects(unencodedString, [NSString stringWithBase64String:encodedString], nil);
}


- (void)testEscapingAndUnescapingHTML {
	NSString *html = @"<a href=\"http://example.com/?ruby%3F=yes&amp;var=T\">example</a>";
	NSString *escapedHtml = @"&lt;a href=&quot;http://example.com/?ruby%3F=yes&amp;amp;var=T&quot;&gt;example&lt;/a&gt;";
	
	GHAssertEqualObjects([html escapeHTML], escapedHtml, nil);
	GHAssertEqualObjects([escapedHtml unescapeHTML], html, nil);
}


- (void)testStringByEscapingForURLQuery {
	GHAssertEqualObjects([@"I want a 27-inch iMac!" stringByEscapingForURLQuery], @"I+want+a+27-inch+iMac%21", nil);
	GHAssertEqualObjects([@"myemail+category@gmail.com" stringByEscapingForURLQuery], @"myemail%2Bcategory%40gmail.com", nil);
}


- (void)testStringByUnescapingFromURLQuery {
	GHAssertEqualObjects([@"I+want+a+27-inch+iMac%21" stringByUnescapingFromURLQuery], @"I want a 27-inch iMac!", nil);
	GHAssertEqualObjects([@"myemail%2Bcategory%40gmail.com" stringByUnescapingFromURLQuery], @"myemail+category@gmail.com", nil);
}


- (void)testUUID {
	NSString *uuid1 = [NSString stringWithUUID];
	NSString *uuid2 = [NSString stringWithUUID];
	GHAssertNotEqualObjects(uuid1, uuid2, nil);
}


- (void)testStringByTrimmingLeadingCharactersInSet {
    NSCharacterSet *letterCharSet = [NSCharacterSet letterCharacterSet];
    GHAssertEqualObjects([@"zip90210zip" stringByTrimmingLeadingCharactersInSet:letterCharSet], @"90210zip", nil);
}


- (void)testStringByTrimmingLeadingWhitespaceAndNewlineCharacters {
    GHAssertEqualObjects([@"" stringByTrimmingLeadingWhitespaceAndNewlineCharacters], @"", nil);
    GHAssertEqualObjects([@"\n \n " stringByTrimmingLeadingWhitespaceAndNewlineCharacters], @"", nil);
    GHAssertEqualObjects([@"\n hello \n" stringByTrimmingLeadingWhitespaceAndNewlineCharacters], @"hello \n", nil);
}


- (void)testStringByTrimmingTrailingCharactersInSet {
    NSCharacterSet *letterCharSet = [NSCharacterSet letterCharacterSet];
    GHAssertEqualObjects([@"zip90210zip" stringByTrimmingTrailingCharactersInSet:letterCharSet], @"zip90210", nil);
}


- (void)testStringByTrimmingTrailingWhitespaceAndNewlineCharacters {
    GHAssertEqualObjects([@"" stringByTrimmingLeadingWhitespaceAndNewlineCharacters], @"", nil);
    GHAssertEqualObjects([@"\n \n " stringByTrimmingLeadingWhitespaceAndNewlineCharacters], @"", nil);
    GHAssertEqualObjects([@"\n hello \n" stringByTrimmingTrailingWhitespaceAndNewlineCharacters], @"\n hello", nil);
}

@end
