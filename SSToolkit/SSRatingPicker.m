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
- (void)_setNumberOfStarsWithTouch:(UITouch *)touch;
@end


@implementation SSRatingPicker

@synthesize numberOfStars = _numberOfStars;
@synthesize totalNumberOfStars = _totalNumberOfStars;
@synthesize emptyStarImage = _emptyStarImage;
@synthesize filledStarImage = _filledStarImage;
@synthesize starSize = _starSize;
@synthesize starSpacing = _starSpacing;
@synthesize textLabel = _textLabel;

#pragma mark NSObject

- (void)dealloc {
	[_emptyStarImage release];
	[_filledStarImage release];
	[_textLabel release];
	[super dealloc];
}


#pragma mark UIResponder

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self _setNumberOfStarsWithTouch:[touches anyObject]];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self _setNumberOfStarsWithTouch:[touches anyObject]];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)rect {
	if ((self = [super initWithFrame:rect])) {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		self.clipsToBounds = YES;
		
		self.emptyStarImage = [UIImage imageNamed:@"gray-star.png" bundle:kSSToolkitBundleName];
		self.filledStarImage = [UIImage imageNamed:@"orange-star.png" bundle:kSSToolkitBundleName];
		self.starSize = CGSizeMake(21.0f, 36.0f);
		self.starSpacing = 19.0f;
		self.numberOfStars = 0.0f;
		self.totalNumberOfStars = 5;
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.textColor = [UIColor colorWithRed:0.612f green:0.620f blue:0.624f alpha:1.0f];
		label.shadowColor = [UIColor whiteColor];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.text = @"Tap a Star to Rate";
		label.font = [UIFont boldSystemFontOfSize:10.0f];
		label.textAlignment = UITextAlignmentCenter;
		self.textLabel = label;
		[self addSubview:label];
		[label release];
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
		UIImage *image = (roundf(_numberOfStars) >= i + 1) ? _filledStarImage : _emptyStarImage;
		
		[image drawInRect:CGRectMake(origin.x + (_starSize.width + _starSpacing) * (CGFloat)i, origin.y, 
									 _starSize.width, _starSize.height)];
	}
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
	[super willMoveToSuperview:newSuperview];
	
	if (newSuperview) {
		[self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"numberOfStars" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
		[self addObserver:self forKeyPath:@"totalNumberOfStars" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"emptyStarImage" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"filledStarImage" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"starSize" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"starSpacing" options:NSKeyValueObservingOptionNew context:nil];
	} else {
		[self removeObserver:self forKeyPath:@"frame"];
		[self removeObserver:self forKeyPath:@"numberOfStars"];
		[self removeObserver:self forKeyPath:@"totalNumberOfStars"];
		[self removeObserver:self forKeyPath:@"emptyStarImage"];
		[self removeObserver:self forKeyPath:@"filledStarImage"];
		[self removeObserver:self forKeyPath:@"starSize"];
		[self removeObserver:self forKeyPath:@"starSpacing"];
	}
}


#pragma mark Private Methods

- (void)_setNumberOfStarsWithTouch:(UITouch *)touch {
	CGPoint point = [touch locationInView:self];
	
	CGFloat totalWidth = (_starSize.width * (CGFloat)_totalNumberOfStars) + 
						 (_starSpacing * (CGFloat)(_totalNumberOfStars - 1));
	CGFloat left = roundf((self.frame.size.width - totalWidth) / 2.0f);
	
	if (point.x < left) {
		self.numberOfStars = 0.0f;
		return;
	}
	
	if (point.x >= left + totalWidth) {
		self.numberOfStars = (CGFloat)_totalNumberOfStars;
		return;
	}
	
	// TODO: Improve
	self.numberOfStars = ceilf((point.x - left) / (_starSize.width + _starSpacing));
}


#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"frame"] || [keyPath isEqualToString:@"totalNumberOfStars"] || [keyPath isEqualToString:@"emptyStarImage"] ||
		[keyPath isEqualToString:@"filledStarImage"] || [keyPath isEqualToString:@"starSize"] || [keyPath isEqualToString:@"starSpacing"]) {
		[self setNeedsDisplay];
		return;
	}
	
	if ([keyPath isEqualToString:@"numberOfStars"]) {
		CGFloat new = [[change valueForKey:NSKeyValueChangeNewKey] floatValue];
		CGFloat old = [[change valueForKey:NSKeyValueChangeOldKey] floatValue];
		
		if (new == old) {
			return;
		}
		
		[self setNeedsDisplay];
		
		// Animate in the text label if necessary
		if ((new > 0 && old == 0) || (new == 0 && old > 0)) {
			[UIView beginAnimations:@"fadeTextLabel" context:nil];
			
			// TODO: Make animation parameters match Apple more
			[UIView setAnimationDuration:0.2];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
			_textLabel.alpha = (new == 0.0f) ? 1.0f : 0.0f;
			[UIView commitAnimations];
		}
		
		[self sendActionsForControlEvents:UIControlEventValueChanged];
		
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
