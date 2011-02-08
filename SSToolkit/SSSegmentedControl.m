//
//  SSSegmentedControl.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/7/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSSegmentedControl.h"
#import "UIImage+SSToolkitAdditions.h"

@implementation SSSegmentedControl

@synthesize numberOfSegments = _numberOfSegments;
@synthesize selectedSegmentIndex = _selectedSegmentIndex;
@synthesize buttonImage = _buttonImage;
@synthesize highlightedButtonImage = _highlightedButtonImage;
@synthesize dividerImage = _dividerImage;
@synthesize highlightedDividerImage = _highlightedDividerImage;

#pragma mark NSObject

- (void)dealloc {
	[_items release];
	[_buttonImage release];
	[_highlightedButtonImage release];
	[_dividerImage release];
	[_highlightedDividerImage release];
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		_items = [[NSMutableArray alloc] init];
		self.buttonImage = [UIImage imageNamed:@"UISegmentedBarButton.png" bundle:kSSToolkitBundleName];
		self.highlightedButtonImage = [UIImage imageNamed:@"UISegmentedBarButtonHighlighted.png" bundle:kSSToolkitBundleName];
		self.dividerImage = [UIImage imageNamed:@"UISegmentedBarDivider.png" bundle:kSSToolkitBundleName];
		self.highlightedDividerImage = [UIImage imageNamed:@"UISegmentedBarDividerHighlighted.png" bundle:kSSToolkitBundleName];
	}
	return self;
}


#pragma mark Initializer

- (id)initWithItems:(NSArray *)items {
	if ((self = [self initWithFrame:CGRectZero])) {
		NSInteger index = 0;
		for (id item in items) {
			if ([item isKindOfClass:[NSString class]]) {
				[self setTitle:item forSegmentAtIndex:index];
				index++;
			}
		}
	}
	return self;
}


#pragma mark Segments

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment {
//	[_items replaceObjectAtIndex:segment withObject:title];
}


- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment {
	if ([_items count] - 1 >= segment) {
		return nil;
	}
	
	id item = [_items objectAtIndex:segment];
	if ([item isKindOfClass:[NSString class]]) {
		return item;
	}
	
	return nil;
}

@end
