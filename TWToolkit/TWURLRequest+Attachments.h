//
//  TWURLRequest+Attachments.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/11/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequest.h"

@interface TWURLRequest (Attachments)

- (void)attachData:(NSData *)data;
- (void)attachImage:(UIImage *)image;

@end
