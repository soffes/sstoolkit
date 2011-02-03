//
//  SSRatingPicker.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/2/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSRatingPicker.h"
#import "SSDrawingMacros.h"
#import "UIImage+SSToolkitAdditions.h"
#import "UIView+SSToolkitAdditions.h"

@implementation SSRatingPicker

@synthesize numberOfStars = _numberOfStars;
@synthesize totalNumberOfStars = _totalNumberOfStars;
@synthesize emptyStarImage = _emptyStarImage;
@synthesize filledStarImage = _filledStarImage;
@synthesize starSize = _starSize;
@synthesize starSpacing = _starSpacing;
@synthesize textLabel = _textLabel;
@synthesize enableHalfStars = _enableHalfStars;

#pragma mark NSObject

- (void)dealloc {
	[_emptyStarImage release];
	[_filledStarImage release];
	[_textLabel release];
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)rect {
	if ((self = [super initWithFrame:rect])) {
		self.clipsToBounds = YES;
		self.topColor = [UIColor colorWithRed:0.878f green:0.890f blue:0.906f alpha:1.0f];
		self.bottomColor = [UIColor colorWithRed:0.961f green:0.965f blue:0.973f alpha:1.0f];
		self.bottomBorderColor = [UIColor colorWithRed:0.839f green:0.839f blue:0.839f alpha:1.0f];
		self.hasTopBorder = NO;
		self.hasBottomBorder = YES;
		self.showsInsets = NO;
		
		self.emptyStarImage = [UIImage imageNamed:@"gray-star.png" bundle:kSSToolkitBundleName];
		self.filledStarImage = [UIImage imageNamed:@"orange-star.png" bundle:kSSToolkitBundleName];
		self.starSize = CGSizeMake(21.0f, 36.0f);
		self.starSpacing = 19.0f;
		self.numberOfStars = 0.0f;
		self.totalNumberOfStars = 5;
		self.enableHalfStars = NO;
		
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
		// TODO: Implement half stars
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
		[self addObserver:self forKeyPath:@"enableHalfStars" options:NSKeyValueObservingOptionNew context:nil];
	} else {
		[self removeObserver:self forKeyPath:@"frame"];
		[self removeObserver:self forKeyPath:@"numberOfStars"];
		[self removeObserver:self forKeyPath:@"totalNumberOfStars"];
		[self removeObserver:self forKeyPath:@"emptyStarImage"];
		[self removeObserver:self forKeyPath:@"filledStarImage"];
		[self removeObserver:self forKeyPath:@"starSize"];
		[self removeObserver:self forKeyPath:@"starSpacing"];
		[self removeObserver:self forKeyPath:@"enableHalfStars"];
	}
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	self.numberOfStars = 3.0f;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
}


#pragma mark NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqual:@"frame"] || [keyPath isEqual:@"totalNumberOfStars"] || [keyPath isEqual:@"emptyStarImage"] ||
		[keyPath isEqual:@"filledStarImage"] || [keyPath isEqual:@"starSize"] || [keyPath isEqual:@"starSpacing"] ||
		[keyPath isEqual:@"enableHalfStars"]) {
		[self setNeedsDisplay];
		return;
	}
	
	if ([keyPath isEqual:@"numberOfStars"]) {
		[self setNeedsDisplay];
		
		CGFloat new = [[change valueForKey:@"new"] floatValue];
		CGFloat old = [[change valueForKey:@"old"] floatValue];
		
		// Animate in the text label if necessary
		if ((new > 0 && old == 0) || (new == 0 && old > 0)) {
			[UIView beginAnimations:@"fadeTextLabel" context:nil];
			[UIView setAnimationDuration:0.15];
			_textLabel.alpha = (new == 0.0f) ? 1.0f : 0.0f;
			[UIView commitAnimations];
		}
		
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
