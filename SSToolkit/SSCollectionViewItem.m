//
//  SSCollectionViewItem.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewItem.h"
#import "SSCollectionViewItemInternal.h"
#import "SSCollectionView.h"
#import "SSCollectionViewInternal.h"
#import "SSLabel.h"
#import "SSDrawingUtilities.h"

@implementation SSCollectionViewItem

@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel;
@synthesize detailTextLabel = _detailTextLabel;
@synthesize backgroundView = _backgroundView;
@synthesize selectedBackgroundView = _selectedBackgroundView;
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize selected = _selected;
@synthesize highlighted = _highlighted;
@synthesize indexPath = _indexPath;
@synthesize collectionView = _collectionView;

#pragma mark NSObject

- (void)dealloc {
	self.collectionView = nil;
	[_indexPath release];
	[_imageView release];
	[_textLabel release];
	[_detailTextLabel release];
	[_backgroundView release];
	[_selectedBackgroundView release];
	[_reuseIdentifier release];
	[super dealloc];
}


#pragma mark UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setHighlighted:YES animated:NO];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setHighlighted:NO animated:NO];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setHighlighted:YES animated:NO];
	
	if (CGRectContainsPoint(CGRectSetZeroOrigin(self.frame), [[touches anyObject] locationInView:self])) {
		[self.collectionView selectItemAtIndexPath:self.indexPath animated:YES scrollPosition:SSCollectionViewScrollPositionNone];
	}
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    return [self initWithStyle:SSCollectionViewItemStyleDefault reuseIdentifier:nil];
}


- (void)layoutSubviews {
	if (_style == SSCollectionViewItemStyleImage) {
		_imageView.frame = CGRectSetZeroOrigin(self.frame);
	}
}


#pragma mark SSCollectionViewItem

- (id)initWithStyle:(SSCollectionViewItemStyle)style reuseIdentifier:(NSString *)aReuseIdentifier {
	if ((self = [super initWithFrame:CGRectZero])) {
		_style = style;
		_reuseIdentifier = [aReuseIdentifier copy];
		
		if (_style != SSCollectionViewItemStyleBlank) {
			_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
			[self addSubview:_imageView];
			
			_textLabel = [[SSLabel alloc] initWithFrame:CGRectZero];
			_textLabel.textAlignment = UITextAlignmentCenter;
			[self addSubview:_textLabel];

			_detailTextLabel = [[SSLabel alloc] initWithFrame:CGRectZero];
			_detailTextLabel.textAlignment = UITextAlignmentCenter;
			[self addSubview:_detailTextLabel];
		}
		
    }
    return self;
}


- (void)prepareForReuse {
	// Do nothing. Subclasses can override this
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	_selected = selected;
	
	for (UIView *view in [self subviews]) {
		if ([view respondsToSelector:@selector(setSelected:)]) {
			[(UIControl *)view setSelected:selected];
		}
	}
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	_highlighted = highlighted;
	
	for (UIView *view in [self subviews]) {
		if ([view respondsToSelector:@selector(setHighlighted:)]) {
			[(UIControl *)view setHighlighted:highlighted];
		}
	}	
}


#pragma mark Setters

- (void)setSelected:(BOOL)selected {
	[self setSelected:selected animated:YES];
}


- (void)setHighlighted:(BOOL)selected {
	[self setHighlighted:selected animated:YES];
}

@end
