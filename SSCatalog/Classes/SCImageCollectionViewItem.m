//
//  SCImageCollectionViewItem.m
//  SSCatalog
//
//  Created by Sam Soffes on 5/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SCImageCollectionViewItem.h"
#import "EGOImageView.h"
#import <SSToolkit/SSDrawingUtilities.h>

@implementation SCImageCollectionViewItem

@synthesize remoteImageView = _remoteImageView;

#pragma mark NSObject

- (void)dealloc {
	[_remoteImageView release];
	[super dealloc];
}


#pragma mark UIView

- (void)layoutSubviews {
	_remoteImageView.frame = CGRectSetZeroOrigin(self.frame);
}


#pragma mark SSCollectionViewItem

- (id)initWithStyle:(SSCollectionViewItemStyle)style reuseIdentifier:(NSString *)aReuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:aReuseIdentifier])) {
		_remoteImageView = [[EGOImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:_remoteImageView];
	}
	return self;
}


- (void)prepareForReuse {
	[super prepareForReuse];
	[_remoteImageView cancelImageLoad];
	_remoteImageView.imageURL = nil;
}

@end
