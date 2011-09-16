//
//  SCImageCollectionViewItem.m
//  SSCatalog
//
//  Created by Sam Soffes on 5/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SCImageCollectionViewItem.h"
#import "UIImageView+AFNetworking.h"

@implementation SCImageCollectionViewItem

#pragma mark -
#pragma mark Accessors

@synthesize imageURL = _imageURL;

- (void)setImageURL:(NSURL *)url {
	[_imageURL release];
	_imageURL = [url retain];
	
	[self.imageView setImageWithURL:url placeholderImage:nil];
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

@end
