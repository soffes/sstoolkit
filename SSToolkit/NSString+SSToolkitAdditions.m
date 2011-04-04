//
//  NSString+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "NSString+SSToolkitAdditions.h"
#include <CommonCrypto/CommonDigest.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"; 

@implementation NSString (SSToolkitAdditions)

- (BOOL)containsString:(NSString *)string {
	return !NSEqualRanges([self rangeOfString:string], NSMakeRange(NSNotFound, 0));
}

- (NSString *)MD5Sum {
	unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
	CC_MD5([self UTF8String], [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
	NSMutableString *ms = [NSMutableString string];
	for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[ms appendFormat: @"%02x", (int)(digest[i])];
	}
	return [[ms copy] autorelease];
}


// Inspired by http://spitzkoff.com/craig/?p=122
- (NSString *)SHA1Sum {
	const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [NSData dataWithBytes:cstr length:self.length];
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	
	CC_SHA1(data.bytes, data.length, digest);
	for (NSInteger i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
		[output appendFormat:@"%02x", digest[i]];
	}
	
	return output;
}


// Adapted from http://snipplr.com/view/2771/compare-two-version-strings
- (NSComparisonResult)compareToVersionString:(NSString *)version {
	// Break version into fields (separated by '.')
	NSMutableArray *leftFields  = [[NSMutableArray alloc] initWithArray:[self  componentsSeparatedByString:@"."]];
	NSMutableArray *rightFields = [[NSMutableArray alloc] initWithArray:[version componentsSeparatedByString:@"."]];
	
	// Implict ".0" in case version doesn't have the same number of '.'
	if ([leftFields count] < [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[leftFields addObject:@"0"];
		}
	} else if ([leftFields count] > [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[rightFields addObject:@"0"];
		}
	}
	
	// Do a numeric comparison on each field
	for (NSUInteger i = 0; i < [leftFields count]; i++) {
		NSComparisonResult result = [[leftFields objectAtIndex:i] compare:[rightFields objectAtIndex:i] options:NSNumericSearch];
		if (result != NSOrderedSame) {
			[leftFields release];
			[rightFields release];
			return result;
		}
	}
	
	[leftFields release];
	[rightFields release];	
	return NSOrderedSame;
}


#pragma mark Localization Methods

+ (NSString *)localizedString:(NSString *)key {
	return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:key];
}


#pragma mark HTML Methods

- (NSString *)escapeHTML {
	NSMutableString *s = [NSMutableString string];
	
	NSUInteger start = 0;
	NSUInteger len = [self length];
	NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
	
	while (start < len) {
		NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
		if (r.location == NSNotFound) {
			[s appendString:[self substringFromIndex:start]];
			break;
		}
		
		if (start < r.location) {
			[s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
		}
		
		switch ([self characterAtIndex:r.location]) {
			case '<':
				[s appendString:@"&lt;"];
				break;
			case '>':
				[s appendString:@"&gt;"];
				break;
			case '"':
				[s appendString:@"&quot;"];
				break;
				//			case '…':
				//				[s appendString:@"&hellip;"];
				//				break;
			case '&':
				[s appendString:@"&amp;"];
				break;
		}
		
		start = r.location + 1;
	}
	
	return s;
}


- (NSString *)unescapeHTML {
	NSMutableString *s = [NSMutableString string];
	NSMutableString *target = [[self mutableCopy] autorelease];
	NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
	
	while ([target length] > 0) {
		NSRange r = [target rangeOfCharacterFromSet:chs];
		if (r.location == NSNotFound) {
			[s appendString:target];
			break;
		}
		
		if (r.location > 0) {
			[s appendString:[target substringToIndex:r.location]];
			[target deleteCharactersInRange:NSMakeRange(0, r.location)];
		}
		
		if ([target hasPrefix:@"&lt;"]) {
			[s appendString:@"<"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&gt;"]) {
			[s appendString:@">"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&quot;"]) {
			[s appendString:@"\""];
			[target deleteCharactersInRange:NSMakeRange(0, 6)];
		} else if ([target hasPrefix:@"&#39;"]) {
			[s appendString:@"'"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		} else if ([target hasPrefix:@"&amp;"]) {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		} else if ([target hasPrefix:@"&hellip;"]) {
			[s appendString:@"…"];
			[target deleteCharactersInRange:NSMakeRange(0, 8)];
		} else {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 1)];
		}
	}
	
	return s;
}


#pragma mark URL Methods

- (NSString *)URLEncodedString {
	return [(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																(CFStringRef)self,
																NULL,
																CFSTR("!*'();:@&=+$,/?%#[]"),
																kCFStringEncodingUTF8) autorelease];
}


- (NSString *)URLEncodedParameterString {
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR(":/=,!$&'()*+;[]@#?"),
                                                                           kCFStringEncodingUTF8);
	return [result autorelease];
}


- (NSString*)URLDecodedString {
	return [(NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																				(CFStringRef)self,
																				CFSTR(""),
																				kCFStringEncodingUTF8) autorelease];
}


- (NSString *)removeQuotes {
	NSUInteger length = [self length];
	NSString *ret = self;
	if ([self characterAtIndex:0] == '"') {
		ret = [ret substringFromIndex:1];
	}
	if ([self characterAtIndex:length - 1] == '"') {
		ret = [ret substringToIndex:length - 2];
	}
	
	return ret;
}


- (NSString*)stringByEscapingForURLQuery {
	NSString *result = self;

	CFStringRef originalAsCFString = (CFStringRef) self;
	CFStringRef leaveAlone = CFSTR(" ");
	CFStringRef toEscape = CFSTR("\n\r?[]()$,!'*;:@&=#%+/");

	CFStringRef escapedStr;
	escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, originalAsCFString, leaveAlone, toEscape, kCFStringEncodingUTF8);

	if (escapedStr) {
		NSMutableString *mutable = [NSMutableString stringWithString:(NSString *)escapedStr];
		CFRelease(escapedStr);

		[mutable replaceOccurrencesOfString:@" " withString:@"+" options:0 range:NSMakeRange(0, [mutable length])];
		result = mutable;
	}
	return result;  
}


- (NSString*)stringByUnescapingFromURLQuery {
	return [[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}


#pragma mark Base64 Methods

- (NSString *)base64EncodedString  {
    if ([self length] == 0) {
        return @"";
	}
	
    const char *source = [self UTF8String];
    NSUInteger strlength  = strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    if (characters == NULL) {
        return nil;
	}
	
    NSUInteger length = 0;
    NSUInteger i = 0;
	
    while (i < strlength) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < strlength) {
            buffer[bufferLength++] = source[i++];
		}
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1) {
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
		} else {
			characters[length++] = '=';
		}
        if (bufferLength > 2) {
            characters[length++] = encodingTable[buffer[2] & 0x3F];
		} else {
			characters[length++] = '=';
		}
    }
    
    return [[[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES] autorelease];
}

@end
