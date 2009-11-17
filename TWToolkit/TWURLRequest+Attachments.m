//
//  TWURLRequest+Attachments.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/11/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequest+Attachments.h"

#define kTWURLRequestAttachementFormBoundary @"0104784892923"

@implementation TWURLRequest (Attachments)

- (void)attachData:(NSData *)data {
	
	// Force the POST method
	// I wonder I something should account for PUTing too...
	[self setHTTPMethod:@"POST"];
	
	// Set the content type
	NSString *contentType = [[NSString alloc] initWithFormat:@"multipart/form-data; boundary=%@", kTWURLRequestAttachementFormBoundary];
    [self setValue:contentType forHTTPHeaderField:@"Content-Type"];
	[contentType release];
	
	// Add length
    [self setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
	
	// Attach data
	[self setHTTPBody:data];
}


- (void)attachPNGImage:(UIImage *)image {
	[self attachData:UIImagePNGRepresentation(image)];
}


- (void)attachJPEGImage:(UIImage *)image {
	[self attachJPEGImage:image compression:0.8];
}


- (void)attachJPEGImage:(UIImage *)image compression:(CGFloat)compression {
	[self attachData:UIImageJPEGRepresentation(image, compression)];
}

@end
