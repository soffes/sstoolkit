//
//  NSString+encoding.h
//  TWToolkit
//
//  Created by Sam Soffes on 7/02/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface NSString (encoding)

+ (NSString*)localizedString:(NSString*)key;
+ (NSString*)base64encode:(NSString*)str;

- (NSString*)encodeAsURIComponent;
- (NSString*)escapeHTML;
- (NSString*)unescapeHTML;
- (NSString *)URLEncodedString;
- (NSString*)URLDecodedString;

@end
