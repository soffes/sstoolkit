//
//  NSData+MD5Sum.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/08.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "NSData+MD5Sum.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5Sum)

- (NSString *)MD5Sum {
	unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
	CC_MD5([self bytes], [self length], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[ms appendFormat: @"%02x", (int)(digest[i])];
	}
	return [[ms copy] autorelease];
}

@end
