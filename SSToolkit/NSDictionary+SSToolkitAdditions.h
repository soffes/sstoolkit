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


///--------------------------
/// @name Deriving New Arrays
///--------------------------

/**
 Returns the object returned by `mutableCopyWithZone:` where the zone is `nil`.
 
 This differs from `mutableCopy` in that it makes any contained `NSArray` objects or `NSDictionary` objects mutable as
 well. The returned dictionary follows standard memory management conventions for copied objects. You are responsible
 for releasing it.
 
 @return The object returned by the `NSMutableCopying` protocol method `mutableCopyWithZone:`, where the zone is `nil`.
 */
- (NSMutableDictionary *)deepMutableCopy NS_RETURNS_RETAINED;


///--------------
/// @name Hashing
///--------------

/**
 Returns a string of the MD5 sum of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the MD5 sum of the receiver.
 */
- (NSString *)MD5Sum;

/**
 Returns a string of the SHA1 sum of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the SHA1 sum of the receiver.
 */
- (NSString *)SHA1Sum;


///------------------------
/// @name Accessing Objects
///------------------------

/**
 Returns the object for the specified key or `nil` if the value is `[NSNull null]`.
 
 @param key The key used to look up the object in the receiver.
 
 @return The object for the specified key or `nil` if the value is `[NSNull null]`.
 */
- (id)safeObjectForKey:(id)key;

@end
