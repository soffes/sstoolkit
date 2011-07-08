//
//  SSRatingPicker.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/2/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSRatingPicker.h"
#import "UIImage+SSToolkitAdditions.h"
#import "UIView+SSToolkitAdditions.h"

@interface SSRatingPicker (PrivateMethods)
- (void)_setSelectedNumberOfStarsWithTouch:(UITouch *)touch;
@end


@implementation SSRatingPicker

#pragma mark - Accessors

@synthesize selectedNumberOfStars = _selectedNumberOfStars;

- (void)setSelectedNumberOfStars:(CGFloat)selectedNumberOfStars {
	if (_selectedNumberOfStars == selectedNumberOfStars) {
		return;
	}
	
	CGFloat old = _selectedNumberOfStars;
	_selectedNumberOfStars = selectedNumberOfStars;
	
	[self setNeedsDisplay];
	
	// Animate in the text label if necessary
	if ((_selectedNumberOfStars > 0 && old == 0) || (_selectedNumberOfStars == 0 && old > 0)) {
		[UIView beginAnimations:@"fadeTextLabel" context:nil];
		
		// TODO: Make animation parameters match Apple more
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		_textLabel.alpha = (_selectedNumberOfStars == 0.0f) ? 1.0f : 0.0f;
		[UIView commitAnimations];
	}
	
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}


@synthesize totalNumberOfStars = _totalNumberOfStars;

- (void)settotalNumberOfStars:(NSUInteger)totalNumberOfStars {
	_totalNumberOfStars = totalNumberOfStars;
	
	[self setNeedsDisplay];
}


@synthesize emptyStarImage = _emptyStarImage;

- (void)setEmptyStarImage:(UIImage *)emptyStarImage {
	[_emptyStarImage release];
	_emptyStarImage = [emptyStarImage retain];
	
	[self setNeedsDisplay];
}


@synthesize filledStarImage = _filledStarImage;

- (void)setFilledStarImage:(UIImage *)filledStarImage {
	[_filledStarImage release];
	_filledStarImage = [filledStarImage retain];
	
	[self setNeedsDisplay];
}


@synthesize starSize = _starSize;

- (void)setStarSize:(CGSize)starSize {
	_starSize = starSize;
	
	[self setNeedsDisplay];
}


@synthesize starSpacing = _starSpacing;

- (void)setStarSpacing:(CGFloat)starSpacing {
	_starSpacing = starSpacing;
	
	[self setNeedsDisplay];
}


@synthesize textLabel = _textLabel;


#pragma mark
#pragma mark NSObject

- (void)dealloc {
	[_emptyStarImage release];
	[_filledStarImage release];
	[_textLabel release];
	[super dealloc];
}


#pragma mark - UIResponder

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self _setSelectedNumberOfStarsWithTouch:[touches anyObject]];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self _setSelectedNumberOfStarsWithTouch:[touches anyObject]];
}


#pragma mark - UIView

- (id)initWithFrame:(CGRect)rect {
	if ((self = [super initWithFrame:rect])) {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		self.contentMode = UIViewContentModeRedraw;
		
		self.emptyStarImage = [UIImage imageNamed:@"gray-star.png" bundleName:kSSToolkitBundleName];
		self.filledStarImage = [UIImage imageNamed:@"orange-star.png" bundleName:kSSToolkitBundleName];
		self.starSize = CGSizeMake(21.0f, 36.0f);
		self.starSpacing = 19.0f;
		self.selectedNumberOfStars = 0.0f;
		self.totalNumberOfStars = 5;
		
		_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_textLabel.textColor = [UIColor colorWithRed:0.612f green:0.620f blue:0.624f alpha:1.0f];
		_textLabel.shadowColor = [UIColor whiteColor];
		_textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		_textLabel.backgroundColor = [UIColor clearColor];
		_textLabel.text = @"Tap a Star to Rate";
		_textLabel.font = [UIFont boldSystemFontOfSize:10.0f];
		_textLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:_textLabel];
	}
	return self;
}


- (CGSize)sizeThatFits:(CGSize)size {
	return CGSizeMake(_starSize.width * (CGFloat)_totalNumberOfStars, _starSize.height);
}


- (void)layoutSubviews {
	CGSize size = self.frame.size;
	_textLabel.frame = CGRectMake(0.0f, size.height - 15.0f, size.width, 12.0f);
}


- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGFloat totalWidth = (_starSize.width * (CGFloat)_totalNumberOfStars) + 
						 (_starSpacing * (CGFloat)(_totalNumberOfStars - 1));
	CGPoint origin = CGPointMake(roundf((rect.size.width - totalWidth) / 2.0f), 10.0f); // TODO: don't hard code the 10
	
	for (NSUInteger i = 0; i < _totalNumberOfStars; i++) {
		UIImage *image = (roundf(_selectedNumberOfStars) >= i + 1) ? _filledStarImage : _emptyStarImage;
		
		[image drawInRect:CGRectMake(origin.x + (_starSize.width + _starSpacing) * (CGFloat)i, origin.y, 
									 _starSize.width, _starSize.height)];
	}
}


#pragma mark - Private Methods

- (void)_setSelectedNumberOfStarsWithTouch:(UITouch *)touch {
	CGPoint point = [touch locationInView:self];
	
	CGFloat totalWidth = (_starSize.width * (CGFloat)_totalNumberOfStars) + 
						 (_starSpacing * (CGFloat)(_totalNumberOfStars - 1));
	CGFloat left = roundf((self.frame.size.width - totalWidth) / 2.0f);
	
	if (point.x < left) {
		self.selectedNumberOfStars = 0.0f;
		return;
	}
	
	if (point.x >= left + totalWidth) {
		self.selectedNumberOfStars = (CGFloat)_totalNumberOfStars;
		return;
	}
	
	// TODO: Improve
	self.selectedNumberOfStars = ceilf((point.x - left) / (_starSize.width + _starSpacing));
}

@end
