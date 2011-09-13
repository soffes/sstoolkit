//
//  NSDictionary+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 9/21/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `NSDictionary` for various common tasks.
 */
@interface NSDictionary (SSToolkitAdditions)

///----------------------------
/// @name Creating Dictionaries
///----------------------------

/**
 Returns a new dictionary that contains a dictionary for a form encoded string.
 
 @param encodedString A string of form encoded compontents.
 
 @return A new dictionary that contains a dictionary for the form encoded string, or `nil` if `encodedString` is an
 invalid representation of a dictionary.
 */
+ (NSDictionary *)dictionaryWithFormEncodedString:(NSString *)encodedString;

///-------------------------------
/// @name Creating Form Components
///-------------------------------

/**
 Returns a string of form encoded components for using as the query string in a URL.
 
 @return A string of form encoded compontents.
 */
- (NSString *)stringWithFormEncodedComponents;

///--------------
/// @name Hashing
///--------------

/**
 Returns a string of the MD5 sum of the receiver.
 
 @return The string of the MD5 sum of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)MD5Sum;

/**
 Returns a string of the SHA1 sum of the receiver.
 
 @return The string of the SHA1 sum of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)SHA1Sum;

@end
