//
//  EGOImageButton.m
//  EGOImageLoading
//
//  Created by Shaun Harrison on 9/30/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGOImageButton.h"


@implementation EGOImageButton
@synthesize imageURL, placeholderImage, delegate;

- (id)initWithPlaceholderImage:(UIImage*)anImage {
	return [self initWithPlaceholderImage:anImage delegate:nil];	
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageButtonDelegate>)aDelegate {
	if((self = [super initWithFrame:CGRectZero])) {
		self.placeholderImage = anImage;
		self.delegate = aDelegate;
		[self setImage:self.placeholderImage forState:UIControlStateNormal];
	}
	
	return self;
}

- (void)setImageURL:(NSURL *)aURL {
	if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		[imageURL release];
		imageURL = nil;
	}
	
	if(!aURL) {
		[self setImage:self.placeholderImage forState:UIControlStateNormal];
		imageURL = nil;
		return;
	} else {
		imageURL = [aURL retain];
	}
	
	UIImage* anImage = [[EGOImageLoader sharedImageLoader] imageForURL:aURL shouldLoadWithObserver:self];
	
	if(anImage) {
		[self setImage:anImage forState:UIControlStateNormal];
		
		// Notify the delegate even when loaded from cache
		if([self.delegate respondsToSelector:@selector(imageButtonLoadedImage:)]) {
			[self.delegate imageButtonLoadedImage:self];
		}
	} else {
		[self setImage:self.placeholderImage forState:UIControlStateNormal];
	}
}

#pragma mark -
#pragma mark Image loading

- (void)cancelImageLoad {
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
}

- (void)imageLoaderDidLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	
	UIImage* anImage = [[notification userInfo] objectForKey:@"image"];
	[self setImage:anImage forState:UIControlStateNormal];
	[self setNeedsDisplay];
	
	if([self.delegate respondsToSelector:@selector(imageButtonLoadedImage:)]) {
		[self.delegate imageButtonLoadedImage:self];
	}	
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	
	if([self.delegate respondsToSelector:@selector(imageButtonFailedToLoadImage:error:)]) {
		[self.delegate imageButtonFailedToLoadImage:self error:[[notification userInfo] objectForKey:@"error"]];
	}
}

#pragma mark -
- (void)dealloc {
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	
	self.imageURL = nil;
	self.placeholderImage = nil;
    [super dealloc];
}

@end
