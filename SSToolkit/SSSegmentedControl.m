//
//  SSSegmentedControl.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/7/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSSegmentedControl.h"
#import "SSDrawingUtilities.h"
#import "UIImage+SSToolkitAdditions.h"

static NSString *kSSSegmentedControlEnabledKey = @"enabled";

@interface SSSegmentedControl ()
- (void)_initialize;
- (NSMutableDictionary *)_metaForSegmentIndex:(NSUInteger)index;
- (id)_metaValueForKey:(NSString *)key segmentIndex:(NSUInteger)index;
- (void)_setMetaValue:(id)value forKey:(NSString *)key segmentIndex:(NSUInteger)index;
@end

@implementation SSSegmentedControl {
	NSMutableArray *_segments;
	NSInteger _selectedSegmentIndex;
	NSMutableDictionary *_segmentMeta;
}


#pragma mark - Accessors

- (NSUInteger)numberOfSegments {
	return [_segments count];
}

@synthesize momentary = _momentary;
@synthesize buttonImage = _buttonImage;

- (void)setButtonImage:(UIImage *)buttonImage {
	[buttonImage retain];
	[_buttonImage release];
	_buttonImage = buttonImage;
	
	[self setNeedsDisplay];
}


@synthesize highlightedButtonImage = _highlightedButtonImage;

- (void)setHighlightedButtonImage:(UIImage *)highlightedButtonImage {
	[highlightedButtonImage retain];
	[_highlightedButtonImage release];
	_highlightedButtonImage = highlightedButtonImage;
	
	[self setNeedsDisplay];
}


@synthesize dividerImage = _dividerImage;

- (void)setDividerImage:(UIImage *)dividerImage {
	[dividerImage retain];
	[_dividerImage release];
	_dividerImage = dividerImage;
	
	[self setNeedsDisplay];
}


@synthesize highlightedDividerImage = _highlightedDividerImage;

- (void)setHighlightedDividerImage:(UIImage *)highlightedDividerImage {
	[highlightedDividerImage retain];
	[_highlightedDividerImage release];
	_highlightedDividerImage = highlightedDividerImage;
	
	[self setNeedsDisplay];
}


@synthesize font = _font;

- (void)setFont:(UIFont *)font {
	[font retain];
	[_font release];
	_font = font;
	
	[self setNeedsDisplay];
}


@synthesize textColor = _textColor;

- (void)setTextColor:(UIColor *)textColor {
	[textColor retain];
	[_textColor release];
	_textColor = textColor;
	
	[self setNeedsDisplay];
}

@synthesize disabledTextColor = _disabledTextColor;

- (void)setDisabledTextColor:(UIColor *)disabledTextColor {
	[disabledTextColor retain];
	[_disabledTextColor release];
	_disabledTextColor = disabledTextColor;
	
	[self setNeedsDisplay];
}


@synthesize textShadowColor = _textShadowColor;

- (void)setTextShadowColor:(UIColor *)textShadowColor {
	[textShadowColor retain];
	[_textShadowColor release];
	_textShadowColor = textShadowColor;
	
	[self setNeedsDisplay];
}


@synthesize textShadowOffset = _textShadowOffset;

- (void)setTextShadowOffset:(CGSize)textShadowOffset {
	_textShadowOffset = textShadowOffset;
	
	[self setNeedsDisplay];
}


@synthesize textEdgeInsets = _textEdgeInsets;

- (void)setTextEdgeInsets:(UIEdgeInsets)textEdgeInsets {
	_textEdgeInsets = textEdgeInsets;
	
	[self setNeedsDisplay];
}


@synthesize selectedSegmentIndex = _selectedSegmentIndex;

- (void)setSelectedSegmentIndex:(NSInteger)index {
	if (_selectedSegmentIndex == index) {
		return;
	}
	
	_selectedSegmentIndex = index;
	[self setNeedsDisplay];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}


- (void)setFrame:(CGRect)rect {
	[super setFrame:rect];
	[self setNeedsDisplay];
}


#pragma mark - NSObject

- (void)dealloc {
	[_segments release];
	[_buttonImage release];
	[_highlightedButtonImage release];
	[_dividerImage release];
	[_highlightedDividerImage release];
	[_font release];
	[_textColor release];
	[_disabledTextColor release];
	[_textShadowColor release];
	[_segmentMeta release];
	[super dealloc];
}


#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGFloat x = [touch locationInView:self].x;
	
	// Ignore touches that don't matter
	if (x < 0 || x > self.frame.size.width) {
		return;
	}
	
	NSUInteger index = (NSUInteger)floorf((CGFloat)x / (self.frame.size.width / (CGFloat)[self numberOfSegments]));
	if ([self isEnabledForSegmentAtIndex:index]) {
		self.selectedSegmentIndex = (NSInteger)index;
	}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!_momentary) {
		return;
	}
	
	_selectedSegmentIndex = UISegmentedControlNoSegment;
	[self setNeedsDisplay];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self _initialize];
	}
	return self;
}


- (void)drawRect:(CGRect)frame {
	static CGFloat dividerWidth = 1.0f;
	
	NSInteger count = (NSInteger)[self numberOfSegments];
	CGSize size = frame.size;
	CGFloat segmentWidth = roundf((size.width - count - 1) / (CGFloat)count);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	for (NSInteger i = 0; i < count; i++) {
		CGContextSaveGState(context);
		
		id item = [_segments objectAtIndex:(NSUInteger)i];
		BOOL enabled = [self isEnabledForSegmentAtIndex:(NSUInteger)i];
		
		CGFloat x = (segmentWidth * (CGFloat)i + (((CGFloat)i + 1) * dividerWidth));
		
		// Draw dividers
		if (i > 0) {
			
			NSInteger p  = i - 1;
			UIImage *dividerImage = nil;
			
			// Selected divider
			if ((p >= 0 && p == _selectedSegmentIndex) || i == _selectedSegmentIndex) {
				dividerImage = _highlightedDividerImage;
			}
			
			// Normal divider
			else {
				dividerImage = _dividerImage;
			}
			
			[dividerImage drawInRect:CGRectMake(x - 1.0f, 0.0f, dividerWidth, size.height)];
		}
		
		CGRect segmentRect = CGRectMake(x, 0.0f, segmentWidth, size.height);
		CGContextClipToRect(context, segmentRect);
		
		// Background
		UIImage *backgroundImage = nil;
		CGRect backgroundRect = segmentRect;
		if (_selectedSegmentIndex == i) {
			backgroundImage = _highlightedButtonImage;
		} else {
			backgroundImage = _buttonImage;
		}
		
		CGFloat capWidth = backgroundImage.leftCapWidth;
		
		// First segment
		if (i == 0) {
			backgroundRect = CGRectSetWidth(backgroundRect, backgroundRect.size.width + capWidth);
		}
		
		// Last segment
		else if (i == count - 1) {
			backgroundRect = CGRectMake(backgroundRect.origin.x - capWidth, backgroundRect.origin.y,
										backgroundRect.size.width + capWidth, backgroundRect.size.height);
		}
		
		// Middle segment
		else {
			backgroundRect = CGRectMake(backgroundRect.origin.x - capWidth, backgroundRect.origin.y,
										backgroundRect.size.width + capWidth + capWidth, backgroundRect.size.height);
		}
		
		[backgroundImage drawInRect:backgroundRect];
		
		// Strings
		if ([item isKindOfClass:[NSString class]]) {
			NSString *string = (NSString *)item;
			CGSize textSize = [string sizeWithFont:_font constrainedToSize:CGSizeMake(segmentWidth, size.height) lineBreakMode:UILineBreakModeTailTruncation];
			CGRect textRect = CGRectMake(x, roundf((size.height - textSize.height) / 2.0f), segmentWidth, size.height);
			textRect = UIEdgeInsetsInsetRect(textRect, _textEdgeInsets);
			
			if (enabled) {
				[_textShadowColor set];
				[string drawInRect:CGRectAddPoint(textRect, CGPointMake(_textShadowOffset.width, _textShadowOffset.height)) withFont:_font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
				
				[_textColor set];
			} else {
				[_disabledTextColor set];
			}
			
			[string drawInRect:textRect withFont:_font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
		}
		
		// Images
		else if ([item isKindOfClass:[UIImage class]]) {
			UIImage *image = (UIImage *)item;
			CGSize imageSize = image.size;
			CGRect imageRect = CGRectMake(x + roundf((segmentRect.size.width - imageSize.width) / 2.0f),
										  roundf((segmentRect.size.height - imageSize.height) / 2.0f),
										  imageSize.width, imageSize.height);
			[image drawInRect:imageRect blendMode:kCGBlendModeNormal alpha:enabled ? 1.0f : 0.5f];
		}
		
		CGContextRestoreGState(context);
	}
}


#pragma mark - Initializer

- (id)initWithItems:(NSArray *)items {
	if ((self = [self initWithFrame:CGRectZero])) {
		[items enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
			if ([object isKindOfClass:[NSString class]]) {
				[self setTitle:object forSegmentAtIndex:index];
			} else if ([object isKindOfClass:[UIImage class]]) {
				[self setImage:object forSegmentAtIndex:index];
			}
		}];
	}
	return self;
}


#pragma mark - Segments

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment {
	if ((NSInteger)([self numberOfSegments] - 1) < (NSInteger)segment) {
		[_segments addObject:title];
	} else {
		[_segments replaceObjectAtIndex:segment withObject:title];
	}
	
	[self setNeedsDisplay];
}


- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment {
	if ([self numberOfSegments] - 1 >= segment) {
		return nil;
	}
	
	id item = [_segments objectAtIndex:segment];
	if ([item isKindOfClass:[NSString class]]) {
		return item;
	}
	
	return nil;
}


- (void)setImage:(UIImage *)image forSegmentAtIndex:(NSUInteger)segment {
	if ((NSInteger)([self numberOfSegments] - 1) < (NSInteger)segment) {
		[_segments addObject:image];
	} else {
		[_segments replaceObjectAtIndex:segment withObject:image];
	}
	
	[self setNeedsDisplay];
}


- (UIImage *)imageForSegmentAtIndex:(NSUInteger)segment {
	if ([self numberOfSegments] - 1 >= segment) {
		return nil;
	}
	
	id item = [_segments objectAtIndex:segment];
	if ([item isKindOfClass:[UIImage class]]) {
		return item;
	}
	
	return nil;
}


- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment {
	[self _setMetaValue:[NSNumber numberWithBool:enabled] forKey:kSSSegmentedControlEnabledKey segmentIndex:segment];
	
}


- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)segment {
	NSNumber *value = [self _metaValueForKey:kSSSegmentedControlEnabledKey segmentIndex:segment];
	if (!value) {
		return YES;
	}
	return [value boolValue];
}


#pragma mark - Private

- (void)_initialize {
	self.backgroundColor = [UIColor clearColor];
	
	_segments = [[NSMutableArray alloc] init];
	_momentary = NO;
	
	self.buttonImage = [[UIImage imageNamed:@"UISegmentBarButton.png" bundleName:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:6 topCapHeight:0];
	self.highlightedButtonImage = [[UIImage imageNamed:@"UISegmentBarButtonHighlighted.png" bundleName:kSSToolkitBundleName] stretchableImageWithLeftCapWidth:6 topCapHeight:0];
	self.dividerImage = [UIImage imageNamed:@"UISegmentBarDivider.png" bundleName:kSSToolkitBundleName];
	self.highlightedDividerImage = [UIImage imageNamed:@"UISegmentBarDividerHighlighted.png" bundleName:kSSToolkitBundleName];
	self.selectedSegmentIndex = SSSegmentedControlNoSegment;
	
	_font = [[UIFont boldSystemFontOfSize:12.0f] retain];
	_textColor = [[UIColor whiteColor] retain];
	_disabledTextColor = [[UIColor colorWithWhite:0.561f alpha:1.0f] retain];
	_textShadowColor = [[UIColor colorWithWhite:0.0f alpha:0.5f] retain];
	_textShadowOffset = CGSizeMake(0.0f, -1.0f);
	_textEdgeInsets = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0f);
}


- (NSMutableDictionary *)_metaForSegmentIndex:(NSUInteger)index {
	if (!_segmentMeta) {
		return nil;
	}
	
	NSString *key = [NSString stringWithFormat:@"%i", index];
	return [_segmentMeta objectForKey:key];
}


- (id)_metaValueForKey:(NSString *)key segmentIndex:(NSUInteger)index {
	NSMutableDictionary *meta = [self _metaForSegmentIndex:index];
	return [meta objectForKey:key];
}


- (void)_setMetaValue:(id)value forKey:(NSString *)key segmentIndex:(NSUInteger)index {
	NSMutableDictionary *meta = [self _metaForSegmentIndex:index];
	if (!meta) {
		meta = [NSMutableDictionary dictionary];
	}
	
	[meta setValue:value forKey:key];
	
	if (!_segmentMeta) {
		_segmentMeta = [[NSMutableDictionary alloc] init];
	}
	
	[_segmentMeta setValue:meta forKey:[NSString stringWithFormat:@"%i", index]];
	[self setNeedsDisplay];
}

@end
