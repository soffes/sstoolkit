//
//  NSArray+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `NSArray` for various common tasks.
 */
@interface NSArray (SSToolkitAdditions)

///------------------------
/// @name Querying an Array
///------------------------

/**
 Returns the object in the array with the lowest index value.
 
 @return The object in the array with the lowest index value. If the array is empty, returns `nil`.
 */
- (id)firstObject;

/**
 Returns the object in the array with a random index value.
 
 @return The object in the array with a random index value. If the array is empty, returns `nil`.
 */
- (id)randomObject;

///--------------------------
/// @name Deriving New Arrays
///--------------------------

/**
 Returns a new array with its elements shuffled.
 
 @return A new array containing the receiving array's elements rearranged in a random order.
 */
- (NSArray *)shuffledArray;

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
