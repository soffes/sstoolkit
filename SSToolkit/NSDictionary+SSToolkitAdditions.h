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

+ (NSDictionary *)dictionaryWithFormEncodedString:(NSString *)encodedString;
- (NSString *)stringWithFormEncodedComponents;

@end
