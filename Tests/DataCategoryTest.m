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


- (void)testBase64 {
	NSString *unencodedString = @"sam";
	NSString *encodedString = @"c2Ft";
	NSData *unencodedData = [unencodedString dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects(encodedString, [unencodedData base64EncodedString], nil);
	GHAssertEqualObjects(unencodedData, [NSData dataWithBase64String:encodedString], nil);
	
	unencodedString = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	encodedString = @"TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2ljaW5nIGVsaXQsIHNlZCBkbyBlaXVzbW9kIHRlbXBvciBpbmNpZGlkdW50IHV0IGxhYm9yZSBldCBkb2xvcmUgbWFnbmEgYWxpcXVhLiBVdCBlbmltIGFkIG1pbmltIHZlbmlhbSwgcXVpcyBub3N0cnVkIGV4ZXJjaXRhdGlvbiB1bGxhbWNvIGxhYm9yaXMgbmlzaSB1dCBhbGlxdWlwIGV4IGVhIGNvbW1vZG8gY29uc2VxdWF0LiBEdWlzIGF1dGUgaXJ1cmUgZG9sb3IgaW4gcmVwcmVoZW5kZXJpdCBpbiB2b2x1cHRhdGUgdmVsaXQgZXNzZSBjaWxsdW0gZG9sb3JlIGV1IGZ1Z2lhdCBudWxsYSBwYXJpYXR1ci4gRXhjZXB0ZXVyIHNpbnQgb2NjYWVjYXQgY3VwaWRhdGF0IG5vbiBwcm9pZGVudCwgc3VudCBpbiBjdWxwYSBxdWkgb2ZmaWNpYSBkZXNlcnVudCBtb2xsaXQgYW5pbSBpZCBlc3QgbGFib3J1bS4=";
	unencodedData = [unencodedString dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects(encodedString, [unencodedData base64EncodedString], nil);
	GHAssertEqualObjects(unencodedData, [NSData dataWithBase64String:encodedString], nil);
	
	unencodedString = @"http://www.cocoadev.com/index.pl?BaseSixtyFour";
	encodedString = @"aHR0cDovL3d3dy5jb2NvYWRldi5jb20vaW5kZXgucGw/QmFzZVNpeHR5Rm91cg==";
	unencodedData = [unencodedString dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects(encodedString, [unencodedData base64EncodedString], nil);
	GHAssertEqualObjects(unencodedData, [NSData dataWithBase64String:encodedString], nil);
}

@end
