//
//  NSData+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 9/29/08.
//  Copyright 2008-2011 Sam Soffes. All rights reserved.
//

#import "NSData+SSToolkitAdditions.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSData (SSToolkitAdditions)

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
