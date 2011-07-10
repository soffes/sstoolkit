//
//  NSString+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `NSString` for various common tasks.
 */
@interface NSString (SSToolkitAdditions)

///------------------------
/// @name Checking Contents
///------------------------

- (BOOL)containsString:(NSString *)string;

///--------------
/// @name Hashing
///--------------

- (NSString *)MD5Sum;
- (NSString *)SHA1Sum;

///-------------------------
/// @name Comparing Versions
///-------------------------

- (NSComparisonResult)compareToVersionString:(NSString *)version;

///-----------------------------------
/// @name HTML Escaping and Unescaping
///-----------------------------------

- (NSString *)escapeHTML;
- (NSString *)unescapeHTML;

///----------------------------------
/// @name URL Encoding and Unencoding
///----------------------------------

- (NSString *)URLEncodedString;
- (NSString *)URLEncodedParameterString;
- (NSString *)URLDecodedString;
- (NSString *)removeQuotes;
- (NSString *)stringByEscapingForURLQuery;
- (NSString *)stringByUnescapingFromURLQuery;

///----------------------
/// @name Base64 Encoding
///----------------------

- (NSString *)base64EncodedString;
+ (NSString *)stringWithBase64String:(NSString *)base64String;

///---------------
/// @name Trimming
///---------------

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters;
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters;

@end
