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

/**
 Returns a string of the MD5 sum of the receiver.
 
 @return The string of the MD5 sum of the receiver.
 */
- (NSString *)MD5Sum;

@end
