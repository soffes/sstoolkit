//
//  SCImageCollectionViewItem.m
//  SSCatalog
//
//  Created by Sam Soffes on 5/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SCImageCollectionViewItem.h"

@implementation SCImageCollectionViewItem

#pragma mark -
#pragma mark Accessors

@synthesize imageURL = _imageURL;

- (void)setImageURL:(NSString *)url {
	[_imageURL release];
	_imageURL = [url retain];
	
	self.imageView.image = [[JMImageCache sharedCache] imageForURL:_imageURL delegate:self];
}


#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[_imageURL release];
	[super dealloc];
}


#pragma mark -
#pragma mark Initializer

- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier {
	if ((self = [super initWithStyle:SSCollectionViewItemStyleImage reuseIdentifier:aReuseIdentifier])) {
		self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
	}
	return self;
}


- (void)prepareForReuse {
	[super prepareForReuse];
	self.imageURL = nil;
}


#pragma mark -
#pragma mark JMImageCacheDelegate

- (void)cache:(JMImageCache *)cache didDownloadImage:(UIImage *)image forURL:(NSString *)url {
	if ([url isEqualToString:_imageURL]) {
		self.imageView.image = image;
		[self setNeedsDisplay];
	}
}

@end
