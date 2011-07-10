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
 Returns a new dictionary that contains a dictionary for the receivers query string.
 
 @return A new dictionary that contains a dictionary for the form encoded string.
 */
- (NSDictionary *)queryDictionary;

@end
