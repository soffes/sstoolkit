//
//  SSCollectionView.m
//  SSToolkit
//
//  Created by Sam Soffes on 6/11/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

#import "SSCollectionView.h"
#import "SSDrawingMacros.h"
#import "UIView+SSToolkitAdditions.h"

@interface SSCollectionView (PrivateMethods)
- (SSCollectionViewItem *)_itemForTouches:(NSSet *)touches event:(UIEvent *)event;
@end


@implementation SSCollectionView

@synthesize dataSource = _dataSource;
@synthesize delegate;
@synthesize rowHeight = _rowHeight;
@synthesize rowSpacing = _rowSpacing;
@synthesize columnWidth = _columnWidth;
@synthesize columnSpacing = _columnSpacing;
@synthesize backgroundView = _backgroundView;
@synthesize backgroundHeaderView = _backgroundHeaderView;
@synthesize backgroundFooterView = _backgroundFooterView;
@synthesize minNumberOfColumns = _minNumberOfColumns;
@synthesize maxNumberOfColumns = _maxNumberOfColumns;
@synthesize minItemSize = _minItemSize;
@synthesize maxItemSize = _maxItemSize;
@synthesize allowsSelection = _allowsSelection;

#pragma mark NSObject

- (void)dealloc {
	self.dataSource = nil;
	self.delegate = nil;
	
	[_items release];
	
	self.backgroundView = nil;
	self.backgroundHeaderView = nil;
	self.backgroundFooterView = nil;
	
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		
		_minNumberOfColumns = 1;
		_maxNumberOfColumns = 0;
		
		_minItemSize = CGSizeMake(40.0f, 40.0f);
		_maxItemSize = CGSizeMake(300.0f, 300.0f);
		
		_rowHeight = 80.0f;
		_rowSpacing = 20.0f;
		_columnWidth = 80.0f;
		_columnSpacing = 20.0f;
		
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
		maxColumns = (NSUInteger)floor((totalWidth + _columnSpacing)  / (_columnWidth + _columnSpacing));
	}
	
	// Calculate padding
	CGFloat horizontalPadding = roundf((totalWidth - (_columnWidth * maxColumns) - (_columnSpacing * (maxColumns - 1))) / 2.0f);
	
	// Calculate verticalOffset
	CGFloat verticalOffset = 0.0f;
	if ([self.delegate respondsToSelector:@selector(collectionView:heightForHeaderInSection:)]) {
		verticalOffset = [self.delegate collectionView:self heightForHeaderInSection:0];
	}
	
	// Calculate bottomPadding
	CGFloat bottomPadding = self.contentInset.bottom;
	if ([self.delegate respondsToSelector:@selector(collectionView:heightForFooterInSection:)]) {
		bottomPadding += [self.delegate collectionView:self heightForFooterInSection:0];
	}
	
	// Layout items
	NSUInteger index = 0;
	NSUInteger row = 0;
	NSInteger column = -1;
	for (SSCollectionViewItem *item in _items) {
		column++;
		if (column >= (NSInteger)maxColumns) {
			column = 0;
			row++;
		}
		item.frame = CGRectMake((column * _columnWidth) + (column * _columnSpacing) + horizontalPadding, (row * _rowHeight) + (row * _rowSpacing) + verticalOffset, _columnWidth, _rowHeight);
		index++;
	}
	
	// Set content size
	CGRect lastFrame = [[_items lastObject] frame];
	CGFloat contentWidth = totalWidth - self.contentInset.left - self.contentInset.right;
	CGFloat contentHeight = lastFrame.origin.y + lastFrame.size.height + bottomPadding;
	CGFloat minContentHeight = (self.frame.size.height - self.contentInset.top - self.contentInset.bottom) + 1.0f;
	self.contentSize = CGSizeMake(contentWidth, fmaxf(contentHeight, minContentHeight));
	
	// Update background views
	_backgroundView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.contentSize.height + self.contentInset.top + self.contentInset.bottom);
	_backgroundHeaderView.frame = CGRectMake(0.0f, -_backgroundHeaderView.frame.size.height, self.frame.size.width, _backgroundHeaderView.frame.size.height);
	_backgroundFooterView.frame = CGRectMake(0.0f, _backgroundView.frame.size.height, self.frame.size.width, _backgroundFooterView.frame.size.height);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	
	SSCollectionViewItem *item = [self _itemForTouches:touches event:event];
	item.highlighted = YES;
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesCancelled:touches withEvent:event];
	
	SSCollectionViewItem *item = [self _itemForTouches:touches event:event];
	item.highlighted = NO;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
	
	SSCollectionViewItem *item = [self _itemForTouches:touches event:event];
	if (!item) {
		return;
	}
	
	item.highlighted = NO;
	item.selected = YES;
	
	// Notify delegate of selection
	if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
		[self.delegate collectionView:self didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:(NSUInteger)item.tag inSection:0]];
	}
}


#pragma mark SSCollectionView

- (void)reloadData {
	// TODO: This is wildly inefficient. Only grab items
	// that will be on the screen
	
	[_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
	[_items removeAllObjects];
	
	NSUInteger total = [_dataSource collectionView:self numberOfRowsInSection:0];
	for (NSUInteger i = 0; i < total; i++) {
		// TODO: Store item so it can be dequeued later
		SSCollectionViewItem *item = [_dataSource collectionView:self itemForIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		
		if (item == nil) {
			NSException *exception = [NSException exceptionWithName:kSSCollectionViewNilItemExceptionName 
															 reason:kSSCollectionViewNilItemExceptionReason userInfo:nil];
			[exception raise];
			return;
		}
		
		item.tag = (NSInteger)i;
		[_items addObject:item];
		[self addSubview:item];
	}
	
	[self setNeedsLayout];
}


- (SSCollectionViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier {
	// TODO: Store items and reuse
	return nil;
}


- (SSCollectionViewItem *)itemPathForIndex:(NSIndexPath *)indexPath {
	if (indexPath.row >= [_items count]) {
		return nil;
	}
	return [_items objectAtIndex:indexPath.row];
}


- (NSIndexPath *)indexPathForItem:(SSCollectionViewItem *)item {
	return [NSIndexPath indexPathForRow:[_items indexOfObject:item] inSection:0];
}


- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	// TODO: Implement
}


- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	SSCollectionViewItem *item = [self itemPathForIndex:indexPath];
	
	if (item) {
		[self scrollRectToVisible:[item frame] animated:animated];
	}
}


- (void)reloadItemAtIndexPaths:(NSIndexPath *)indexPaths {
	if ([indexPaths row] < [_items count]) {
		SSCollectionViewItem *oldItem = [_items objectAtIndex:[indexPaths row]];
		SSCollectionViewItem *newItem = [_dataSource collectionView:self itemForIndexPath:indexPaths];
		
		if (newItem == nil) {
			NSException *exception = [NSException exceptionWithName:kSSCollectionViewNilItemExceptionName 
															 reason:kSSCollectionViewNilItemExceptionReason userInfo:nil];
			[exception raise];
			return;
		}
		
		[newItem setFrame:[oldItem frame]];
		[newItem setTag:[oldItem tag]];
		[_items replaceObjectAtIndex:[indexPaths row] withObject:newItem];
		[oldItem removeFromSuperview];
		[self addSubview:newItem];
	}
}


#pragma mark Private Methods

- (SSCollectionViewItem *)_itemForTouches:(NSSet *)touches event:(UIEvent *)event {
	CGPoint point = [[touches anyObject] locationInView:self];
	UIView *view = [self hitTest:point withEvent:event];
	if (view == self || view == _backgroundView) {
		return nil;
	}
	
	if([view isKindOfClass:[SSCollectionViewItem class]]) {
		return (SSCollectionViewItem*)view;
	} else {
		return [view firstSuperviewOfClass:[SSCollectionViewItem class]];
	}
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


- (void)setBackgroundView:(UIView *)background {
	[_backgroundView removeFromSuperview];
	[_backgroundView release];
	
	_backgroundView = [background retain];
	_backgroundView.tag = -1;
	_backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self insertSubview:_backgroundView atIndex:0];
	
	[self setNeedsLayout];
}


- (void)setBackgroundHeaderView:(UIView *)backgroundHeader {
	[_backgroundHeaderView removeFromSuperview];
	[_backgroundHeaderView release];
	
	_backgroundHeaderView = [backgroundHeader retain];
	_backgroundHeaderView.tag = -2;
	_backgroundHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	if (_backgroundView) {
		[self insertSubview:_backgroundHeaderView aboveSubview:_backgroundView];
	} else {
		[self insertSubview:_backgroundHeaderView atIndex:0];
	}
	
	[self setNeedsLayout];
}


- (void)setBackgroundFooterView:(UIView *)backgroundFooter {
	[_backgroundFooterView removeFromSuperview];
	[_backgroundFooterView release];
	
	_backgroundFooterView = [backgroundFooter retain];
	_backgroundFooterView.tag = -3;
	_backgroundFooterView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	if (_backgroundView) {
		[self insertSubview:_backgroundFooterView aboveSubview:_backgroundView];
	} else {
		[self insertSubview:_backgroundFooterView atIndex:0];
	}
	
	[self setNeedsLayout];
}


@end
