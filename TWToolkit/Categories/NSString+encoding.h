//
//  NSString+encoding.h
//  Four80
//
//  Created by Sam Soffes on 7/02/09.
//  Copyright 2008 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encoding)

- (NSString*)encodeAsURIComponent;
- (NSString*)escapeHTML;
- (NSString*)unescapeHTML;
+ (NSString*)localizedString:(NSString*)key;
+ (NSString*)base64encode:(NSString*)str;

@end
