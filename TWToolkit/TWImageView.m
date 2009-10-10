//
//  TWImageView.m
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWImageView.h"
#import "UIView+fading.h"

@implementation TWImageView

@synthesize delegate;
@synthesize URL;
@synthesize remoteImageView;
@synthesize placeholderImageView;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[URL release];
	[remoteImageView release];
	[placeholderImageView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		URL = nil;
		connection = nil;
		
		self.clipsToBounds = YES;
		
		// Setup image views
		remoteImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		remoteImageView.contentMode = UIViewContentModeScaleAspectFill;
		remoteImageView.alpha = 0.0;
				
		placeholderImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		placeholderImageView.contentMode = UIViewContentModeScaleAspectFill;
		[self addSubview:placeholderImageView];
    }
    return self;
}


- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGRect imageRect = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
	
	remoteImageView.frame = imageRect;
	placeholderImageView.frame = imageRect;
}


#pragma mark -
#pragma mark Setters
#pragma mark -

- (void)setURL:(NSURL *)aURL {
	if ([URL isEqual:aURL]) {
		return;
	}
	
	[URL release];
	URL = [aURL retain];
	
	[connection release];
	connection = [[TWConnection alloc] initWithDelegate:self];
	connection.dataType = TWConnectionDataTypeImage;
	[connection requestURL:URL];
}


#pragma mark -
#pragma mark TWConnectionDelegate
#pragma mark -


- (void)connection:(TWConnection *)aConnection startedLoadingRequest:(NSURLRequest *)aRequest {
	
}


- (void)connection:(TWConnection *)aConnection didReceiveBytes:(NSInteger)receivedBytes totalReceivedBytes:(NSInteger)totalReceivedBytes totalExpectedBytes:(NSInteger)totalExpectedBytes {
	NSLog(@"receivedBytes: %i, totalReceivedBytes: %i, totalExpectedBytes: %i", receivedBytes, totalReceivedBytes, totalExpectedBytes);
}


- (void)connection:(TWConnection *)aConnection didFinishLoadingRequest:(NSURLRequest *)aRequest withResult:(id)result {
	remoteImageView.image = (UIImage *)result;
	[self addSubview:remoteImageView];
	[remoteImageView fadeIn];
}


- (void)connection:(TWConnection *)aConnection failedWithError:(NSError *)error {	

}

@end
