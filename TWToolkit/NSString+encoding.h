//
//  NSString+encoding.h
//  TWToolkit
//
//  Created by Sam Soffes on 7/02/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encoding)

- (NSString*)encodeAsURIComponent;
- (NSString*)escapeHTML;
- (NSString*)unescapeHTML;
+ (NSString*)localizedString:(NSString*)key;
+ (NSString*)base64encode:(NSString*)str;

@end
