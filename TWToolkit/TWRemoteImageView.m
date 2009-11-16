//
//  TWRemoteImageView.m
//  TWToolkit
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWRemoteImageView.h"
#import "TWURLRequest.h"
#import "TWURLConnectionQueue.h"
#import "UIView+fading.h"

@implementation TWRemoteImageView

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
	
	TWURLRequest *request = [[TWURLRequest alloc] initWithURL:URL];
	request.dataType = TWURLRequestDataTypeImage;
	[[TWURLConnectionQueue defaultQueue] addRequest:request delegate:self];
	[request release];
}


#pragma mark -
#pragma mark TWURLConnectionDelegate
#pragma mark -

- (void)connectionStartedLoading:(TWURLConnection *)aConnection {
	if ([delegate respondsToSelector:@selector(remoteImageViewDidStartLoading:)]) {
		[delegate remoteImageViewDidStartLoading:self];
	}
}


- (void)connection:(TWURLConnection *)aConnection didFinishLoadingWithResult:(id)result {
	// Fade in image
	remoteImageView.image = (UIImage *)result;
	[self addSubview:remoteImageView];
	[remoteImageView fadeIn];
	
	// Notify delegate
	if ([delegate respondsToSelector:@selector(remoteImageView:didLoadImage:)]) {
		[delegate remoteImageView:self didLoadImage:remoteImageView.image];
	}
}


- (void)connection:(TWURLConnection *)aConnection didFailLoadWithError:(NSError *)error {
	if ([delegate respondsToSelector:@selector(remoteImageView:didFailWithError:)]) {
		[delegate remoteImageView:self didFailWithError:error];
	}
}

@end
