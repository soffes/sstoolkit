//
//  SSCollectionView.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSCollectionView.h"

@implementation SSCollectionView

@synthesize dataSource = _dataSource;
@synthesize delegate;
@synthesize rowHeight = _rowHeight;
@synthesize rowSpacing = _rowSpacing;
@synthesize columnWidth = _columnWidth;
@synthesize columnSpacing = _columnSpacing;
@synthesize backgroundView = _backgroundView;
@synthesize collectionHeaderView = _collectionHeaderView;
@synthesize collectionFooterView = _collectionFooterView;
@synthesize minNumberOfColumns = _minNumberOfColumns;
@synthesize maxNumberOfColumns = _maxNumberOfColumns;
@synthesize minItemSize = _minItemSize;
@synthesize maxItemSize = _maxItemSize;
@synthesize allowsSelection = _allowsSelection;

#pragma mark NSObject

- (void)dealloc {
	[_items release];
	[_backgroundView release];
	[_collectionHeaderView release];
	[_collectionFooterView release];
	[super dealloc];
}

#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		_minNumberOfColumns = 1;
		_maxNumberOfColumns = 0;
		
		_minItemSize = CGSizeMake(40.0, 40.0);
		_maxItemSize = CGSizeMake(300.0, 300.0);
		
		_rowHeight = 80.0;
		_rowSpacing = 20.0;
		_columnWidth = 80.0;
		_columnSpacing = 20.0;
		
		_allowsSelection = YES;
		_items = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)layoutSubviews {
	// Calculate columns
	CGFloat totalWidth = self.frame.size.width;
	NSUInteger maxColumns;
	if (_maxNumberOfColumns > 0) {
		maxColumns = _maxNumberOfColumns;
	} else {
		maxColumns = floor((totalWidth + _columnSpacing)  / (_columnWidth + _columnSpacing));
	}
	
	// Calculate padding
	CGFloat padding = roundf((totalWidth - (_columnWidth * maxColumns) - (_columnSpacing * (maxColumns - 1))) / 2.0);
	
	// Layout items
	NSUInteger index = 0;
	NSUInteger row = 0;
	NSUInteger column = -1;
	for (SSCollectionViewItem *item in _items) {
		column++;
		if (column >= maxColumns) {
			column = 0;
			row++;
		}
		item.frame = CGRectMake((column * _columnWidth) + (column * _columnSpacing) + padding, (row * _rowHeight) + (row * _rowSpacing) + padding, _columnWidth, _rowHeight);
		index++;
	}
	
	// Set content size
	CGRect lastFrame = [[_items lastObject] frame];
	CGFloat contentWidth = totalWidth - self.contentInset.left - self.contentInset.right;
	CGFloat contentHeight = lastFrame.origin.y + lastFrame.size.height + padding;
	CGFloat minContentHeight = (self.frame.size.height - self.contentInset.top - self.contentInset.bottom) + 1.0;
	self.contentSize = CGSizeMake(contentWidth, fmax(contentHeight, minContentHeight));
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	
	CGPoint point = [[touches anyObject] locationInView:self];
	SSCollectionViewItem *item = (SSCollectionViewItem *)[self hitTest:point withEvent:event];
	if ((UIView *)item == self) {
		return;
	}
	
	// Highlight item
	item.highlighted = YES;
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesCancelled:touches withEvent:event];

	CGPoint point = [[touches anyObject] locationInView:self];
	SSCollectionViewItem *item = (SSCollectionViewItem *)[self hitTest:point withEvent:event];
	if ((UIView *)item == self) {
		return;
	}
	
	// Remove highlight
	item.highlighted = NO;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	
	CGPoint point = [[touches anyObject] locationInView:self];
	SSCollectionViewItem *item = (SSCollectionViewItem *)[self hitTest:point withEvent:event];
	if ((UIView *)item == self) {
		return;
	}
	
	item.highlighted = NO;
	item.selected = YES;
	
	// Notify delegate of selection
	if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndex:)]) {
		[self.delegate collectionView:self didSelectItemAtIndex:item.tag];
	}
}


#pragma mark SSCollectionView

- (void)reloadData {
	// TODO: This is wildly inefficient. Only grab items
	// that will be on the screen
	
	[_items removeAllObjects];
	
	NSUInteger total = [_dataSource numberOfItemsInCollectionView:self];
	for (NSUInteger i = 0; i < total; i++) {
		// TODO: Store item so it can be dequeued later
		SSCollectionViewItem *item = [_dataSource collectionView:self itemForIndex:i];
		item.tag = i;
		[_items addObject:item];
		[self addSubview:item];
	}
	
	[self setNeedsLayout];
}


- (SSCollectionViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier {
	// TODO: Store items and reuse
	return nil;
}


#pragma mark Setters

- (void)setDataSource:(id<SSCollectionViewDataSource>)dataSource {
	_dataSource = dataSource;
	[self reloadData];
}


- (void)setFrame:(CGRect)rect {
	[super setFrame:rect];
	
	[UIView beginAnimations:@"SSCollectionViewAnimationUpdateLayout" context:self];
	[self setNeedsLayout];
	[UIView commitAnimations];
}

@end
