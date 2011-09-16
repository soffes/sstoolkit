//
//  NSURL+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 4/27/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `NSURL` for various common tasks.
 */
@interface NSURL (SSToolkitAdditions)

/**
 Creates and returns an NSURL object initialized with a provided a format string as a template into which the remaining
 argument values are substituted.
 
 The string with which to initialize the NSURL object must be a URL that conforms to RFC 2396. This method parses
 URLString according to RFCs 1738 and 1808. This method expects URLString to contain any necessary percent escape codes,
 which are `:`, `/`, `%`, `#`, `;`, and `@`. Note that `%` escapes are translated via UTF-8.
 
 @param format A format string. See "[Formatting String Objects](http://developer.apple.com/library/IOS/#documentation/Cocoa/Conceptual/Strings/Articles/FormatStrings.html)"
 for examples of how to use this method, and "[String Format Specifiers](http://developer.apple.com/library/IOS/#documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html#//apple_ref/doc/uid/TP40004265-SW1)"
 for a list of format specifiers. This value must not be `nil`.
 
 @param ... A comma-separated list of arguments to substitute into format.
 
 @return An NSURL object initialized with URLString. If the string was malformed, returns nil.
 
 @exception NSInvalidArgumentException Thrown if `format` is `nil`.
 */
+ (id)URLWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 Returns a new dictionary that contains a dictionary for the receivers query string.
 
 @return A new dictionary that contains a dictionary for the form encoded string.
 */
- (NSDictionary *)queryDictionary;

@end
