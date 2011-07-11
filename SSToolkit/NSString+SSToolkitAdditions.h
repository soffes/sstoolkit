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
 Returns a comparison result for the reciever and a given `version`.
 
 Examples:
 
 <pre><code>[@"10.4" compareToVersionString:@"10.3"]; // NSOrderedDescending
 [@"10.5" compareToVersionString:@"10.5.0"]; // NSOrderedSame
 [@"10.4 Build 8L127" compareToVersionString:@"10.4 Build 8P135"]; // NSOrderedAscending</code></pre>
 
 @param version A version string to compare to the receiver
 
 @return A comparison result for the reciever and a given `version`
 */
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

///---------------
/// @name Trimming
///---------------

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters;
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters;

@end
