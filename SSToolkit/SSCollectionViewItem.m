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

@implementation SSCollectionViewItem {
	SSCollectionViewItemStyle _style;
	SSCollectionView *_collectionView;
	NSIndexPath *_indexPath;
}


#pragma mark - Accessors

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

- (void)setBackgroundView:(UIView *)backgroundView {
	[backgroundView retain];
	[_backgroundView release];
	_backgroundView = backgroundView;
	
	_backgroundView.hidden = _selected && _selectedBackgroundView;
	
	[self insertSubview:backgroundView atIndex:0];
	[self setNeedsLayout];
}


- (void)setSelectedBackgroundView:(UIView *)selectedBackgroundView {
	[selectedBackgroundView retain];
	[_selectedBackgroundView release];
	_selectedBackgroundView = selectedBackgroundView;
	
	_selectedBackgroundView.hidden = !_selected;
	
	if (_backgroundView) {
		[self insertSubview:_selectedBackgroundView aboveSubview:_backgroundView];
	} else {
		[self insertSubview:_selectedBackgroundView atIndex:0];
	}
	
	[self setNeedsLayout];
}


#pragma mark - NSObject

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


#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setHighlighted:YES animated:NO];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setHighlighted:NO animated:NO];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setHighlighted:YES animated:NO];
	
	if (CGRectContainsPoint(self.bounds, [[touches anyObject] locationInView:self])) {
        if (self.isSelected) {
            [self.collectionView deselectItemAtIndexPath:self.indexPath animated:YES];
        } else {
            [self.collectionView selectItemAtIndexPath:self.indexPath animated:YES scrollPosition:SSCollectionViewScrollPositionNone];
        }
	}
}


#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame {
    return [self initWithStyle:SSCollectionViewItemStyleDefault reuseIdentifier:nil];
}


- (void)layoutSubviews {
	_backgroundView.frame = self.bounds;
	_selectedBackgroundView.frame = self.bounds;
	
	if (_style == SSCollectionViewItemStyleImage) {
		_imageView.frame = self.bounds;
	} else if (_style == SSCollectionViewItemStyleDefault) {
		_textLabel.frame = self.bounds;
	}
}


#pragma mark - SSCollectionViewItem

- (id)initWithStyle:(SSCollectionViewItemStyle)style reuseIdentifier:(NSString *)aReuseIdentifier {
	if ((self = [super initWithFrame:CGRectZero])) {
		_style = style;
		_reuseIdentifier = [aReuseIdentifier copy];
		
		if (_style != SSCollectionViewItemStyleBlank) {
			if (_style == SSCollectionViewItemStyleSubtitle) {
				_detailTextLabel = [[SSLabel alloc] initWithFrame:CGRectZero];
				_detailTextLabel.textAlignment = UITextAlignmentCenter;
				[self addSubview:_detailTextLabel];
			}
			
			_textLabel = [[SSLabel alloc] initWithFrame:CGRectZero];
			_textLabel.textAlignment = UITextAlignmentCenter;
			[self addSubview:_textLabel];
			
			_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
			[self addSubview:_imageView];
		}
		
    }
    return self;
}


- (void)prepareForReuse {
	// Do nothing. Subclasses can override this
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	_selected = selected;
	
	void (^changes)(void) = ^{
		for (UIView *view in [self subviews]) {
			if ([view respondsToSelector:@selector(setSelected:)]) {
				[(UIControl *)view setSelected:_selected];
			}
		}
		
		_backgroundView.hidden = _selected && _selectedBackgroundView;
		_selectedBackgroundView.hidden = !_selected;
	};
	
	if (animated) {
		[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:changes completion:nil];
	} else {
		changes();
	}
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	_highlighted = highlighted;
	
	void (^changes)(void) = ^{
		for (UIView *view in [self subviews]) {
			if ([view respondsToSelector:@selector(setHighlighted:)]) {
				[(UIControl *)view setHighlighted:_highlighted];
			}
		}
	};
	
	if (animated) {
		[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:changes completion:nil];
	} else {
		changes();
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
