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

/**
 Returns a Boolean if the receiver contains the given `string`.
 
 @param string A string to test the the receiver for
 
 @return A Boolean if the receiver contains the given `string`
 */
- (BOOL)containsString:(NSString *)string;


///--------------
/// @name Hashing
///--------------

/**
 Returns a string of the MD5 sum of the receiver.
 
 @return The string of the MD5 sum of the receiver.
 */
- (NSString *)MD5Sum;

/**
 Returns a string of the SHA1 sum of the receiver.
 
 @return The string of the SHA1 sum of the receiver.
 */
- (NSString *)SHA1Sum;


///-------------------------
/// @name Comparing Versions
///-------------------------

/**
 Returns a comparison result for the receiver and a given `version`.
 
 Examples:
 
 <pre><code>[@"10.4" compareToVersionString:@"10.3"]; // NSOrderedDescending
 [@"10.5" compareToVersionString:@"10.5.0"]; // NSOrderedSame
 [@"10.4 Build 8L127" compareToVersionString:@"10.4 Build 8P135"]; // NSOrderedAscending</code></pre>
 
 @param version A version string to compare to the receiver
 
 @return A comparison result for the receiver and a given `version`
 */
- (NSComparisonResult)compareToVersionString:(NSString *)version;


///-----------------------------------
/// @name HTML Escaping and Unescaping
///-----------------------------------

/**
 Returns a new string with any HTML escaped.
 
 @return A new string with any HTML escaped.
 
 @see unescapeHTML
 */
- (NSString *)escapeHTML;

/**
 Returns a new string with any HTML unescaped.
 
 @return A new string with any HTML unescaped.
 
 @see escapeHTML
 */
- (NSString *)unescapeHTML;


///----------------------------------
/// @name URL Escaping and Unescaping
///----------------------------------

/**
 Returns a new string escaped for a URL query parameter.
 
 The following characters are escaped: `\n\r:/=,!$&'()*+;[]@#?%`. Spaces are escaped to the `+` character. (`+` is
 escaped to `%2B`).
 
 @return A new string escaped for a URL query parameter.
 
 @see stringByUnescapingFromURLQuery
 */
- (NSString *)stringByEscapingForURLQuery;

/**
 Returns a new string unescaped from a URL query parameter.
 
 `+` characters are unescaped to spaces.
 
 @return A new string escaped for a URL query parameter.
 
 @see stringByEscapingForURLQuery
 */
- (NSString *)stringByUnescapingFromURLQuery;


///-----------------------------------------------
/// @name URL Encoding and Unencoding (Deprecated)
///-----------------------------------------------

/**
 Returns a new string encoded for a URL. (Deprecated)
 
 The following characters are encoded: `:/=,!$&'()*+;[]@#?%`.
 
 @return A new string escaped for a URL.
 */
- (NSString *)URLEncodedString;

/**
 Returns a new string encoded for a URL parameter. (Deprecated)
 
 The following characters are encoded: `:/=,!$&'()*+;[]@#?`.
 
 @return A new string escaped for a URL parameter.
 */
- (NSString *)URLEncodedParameterString;

/**
 Returns a new string decoded from a URL.
 
 @return A new string decoded from a URL.
 */
- (NSString *)URLDecodedString;


///----------------------
/// @name Base64 Encoding
///----------------------

/**
 Returns a string representation of the receiver Base64 encoded.
 
 @return A Base64 encoded string
 */
- (NSString *)base64EncodedString;

/**
 Returns a new string contained in the Base64 encoded string.
 
 This uses `NSData`'s `dataWithBase64String:` method to do the conversion then initializes a string with the resulting
 `NSData` object using `NSUTF8StringEncoding`.
 
 @param base64String A Base64 encoded string
 
 @return String contained in `base64String`
 */
+ (NSString *)stringWithBase64String:(NSString *)base64String;


///------------------------
/// @name Generating a UUID
///------------------------

/**
 Returns a new string containing a Universally Unique Identifier.
 */
+ (NSString *)stringWithUUID;

///---------------
/// @name Trimming
///---------------

/**
 Returns a new string by trimming leading and trailing characters in a given `NSCharacterSet`.
 
 @param characterSet Character set to trim characters
 
 @return A new string by trimming leading and trailing characters in `characterSet`
 */
- (NSString *)stringByTrimmingLeadingAndTrailingCharactersInSet:(NSCharacterSet *)characterSet;

/**
 Returns a new string by trimming leading and trailing whitespace and newline characters.
  
 @return A new string by trimming leading and trailing whitespace and newline characters 
 */
- (NSString *)stringByTrimmingLeadingAndTrailingWhitespaceAndNewlineCharacters;

/**
 Returns a new string by trimming leading characters in a given `NSCharacterSet`.
 
 @param characterSet Character set to trim characters
 
 @return A new string by trimming leading characters in `characterSet`
 */
- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;

/**
 Returns a new string by trimming leading whitespace and newline characters.
 
 @return A new string by trimming leading whitespace and newline characters 
 */
- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters;

/**
 Returns a new string by trimming trailing characters in a given `NSCharacterSet`.
 
 @param characterSet Character set to trim characters
 
 @return A new string by trimming trailing characters in `characterSet`
 */
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;

/**
 Returns a new string by trimming trailing whitespace and newline characters.
 
 @return A new string by trimming trailing whitespace and newline characters 
 */
- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters;

@end
