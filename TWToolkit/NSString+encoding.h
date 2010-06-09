//
//  NSString+encoding.h
//  TWToolkit
//
//  Created by Sam Soffes on 7/02/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface NSString (encoding)

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
