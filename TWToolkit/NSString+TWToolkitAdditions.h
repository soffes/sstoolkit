//
//  NSString+TWToolkitAdditions.h
//  TWToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface NSString (TWToolkitAdditions)

- (BOOL)containsString:(NSString *)string;
- (NSString *)MD5Sum;
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

// Base64
- (NSString *)base64EncodedString;

@end
