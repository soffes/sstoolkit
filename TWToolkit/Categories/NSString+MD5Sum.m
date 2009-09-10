//
//  NSString+MD5Sum.m
//  Four80
//
//  Created by Sam Soffes on 8/15/08.
//  Copyright 2008 Sam Soffes. All rights reserved.
//

#import "NSString+MD5Sum.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5Sum)

- (NSString *)MD5Sum {
	unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
	CC_MD5([self UTF8String], [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i=0;i<CC_MD5_DIGEST_LENGTH;i++) {
		[ms appendFormat: @"%02x", (int)(digest[i])];
	}
	return [[ms copy] autorelease];
}

@end
