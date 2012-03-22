//
//  NSBundle+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/22/12.
//  Copyright (c) 2012 Sam Soffes. All rights reserved.
//

#define SSToolkitLocalizedString(key) [[NSBundle ssToolkitBundle] localizedStringForKey:(key) value:@"" table:@"SSToolkit"]

@interface NSBundle (SSToolkitAdditions)

+ (NSBundle *)ssToolkitBundle;

@end
