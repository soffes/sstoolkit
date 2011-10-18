//
//  NSData+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 9/29/08.
//  Copyright 2008-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `NSData` for various common tasks.
 */
@interface NSData (SSToolkitAdditions)

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


///-----------------------------------
/// @name Base64 Encoding and Decoding
///-----------------------------------

/**
 Returns a string representation of the receiver Base64 encoded.
 
 @return A Base64 encoded string
 */
- (NSString *)base64EncodedString;

/**
 Returns a new data contained in the Base64 encoded string.
 
 @param base64String A Base64 encoded string
 
 @return Data contained in `base64String`
 */
+ (NSData *)dataWithBase64String:(NSString *)base64String;

@end
