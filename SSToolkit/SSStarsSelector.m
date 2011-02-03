//
//  SSStarsSelector.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/2/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSStarsSelector.h"
#import "SSDrawingMacros.h"
#import "UIImage+SSToolkitAdditions.h"

@implementation SSStarsSelector

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
		[_emptyStarImage drawInRect:CGRectMake(origin.x + (_starSize.width + _starSpacing) * (CGFloat)i, origin.y, _starSize.width, _starSize.height)];
	}
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setNeedsDisplay];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setNeedsDisplay];
}

@end
