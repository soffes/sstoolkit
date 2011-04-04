//
//  NSString+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

@interface NSString (SSToolkitAdditions)

- (BOOL)containsString:(NSString *)string;
- (NSString *)MD5Sum;
- (NSString *)SHA1Sum;
- (NSComparisonResult)compareToVersionString:(NSString *)version;

// Localization
+ (NSString *)localizedString:(NSString*)key;

// HTML
- (NSString *)escapeHTML;
- (NSString *)unescapeHTML;

// URL
- (NSString *)URLEncodedString;
- (NSString *)URLEncodedParameterString;
- (NSString *)URLDecodedString;
- (NSString *)removeQuotes;
- (NSString *)stringByEscapingForURLQuery;
- (NSString *)stringByUnescapingFromURLQuery;

// Base64
- (NSString *)base64EncodedString;

@end
