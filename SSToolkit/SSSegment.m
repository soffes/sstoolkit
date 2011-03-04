//
//  SSSegment.m
//  SSToolkit
//
//  Created by Sam Soffes on 3/3/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSSegment.h"

@implementation SSSegment

@synthesize enabled = _enabled;
@synthesize highlighted = _highlighted;
@synthesize selected = _selected;
@synthesize position = _position;
@synthesize contentView = _contentView;
@synthesize backgroundImage = _backgroundImage;
@synthesize highlightedBackgroundImage = _highlightedBackgroundImage;
@synthesize dividerImage = _dividerImage;
@synthesize highlightedDividerImage = _highlightedDividerImage;

#pragma mark NSObject

- (void)dealloc {
	[_contentView release];
	[_backgroundImage release];
	[_highlightedBackgroundImage release];
	[_dividerImage release];
	[_highlightedBackgroundImage release];
	[super dealloc];
}

@end
