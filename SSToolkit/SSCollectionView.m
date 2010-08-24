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
		
		self.contentInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0);
		
		_minNumberOfColumns = 1;
		_maxNumberOfColumns = 3; // TODO: Make dynamic
		
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
	NSUInteger index = 0;
	NSUInteger row = 0;
	NSUInteger column = -1;
	for (SSCollectionViewItem *item in _items) {
		column++;
		if (column >= _maxNumberOfColumns) {
			column = 0;
			row++;
		}
		item.frame = CGRectMake((column * _columnWidth) + (column * _columnSpacing), (row * _rowHeight) + (row * _rowSpacing), _columnWidth, _rowHeight);
		index++;
	}
	
	CGRect lastFrame = [[_items lastObject] frame];
	self.contentSize = CGSizeMake(self.frame.size.width - self.contentInset.left - self.contentInset.right, lastFrame.origin.y + lastFrame.size.height);
}


#pragma mark SSCollectionView

- (void)reloadData {
	// TODO: This is wildly inefficient. Only grab items
	// that will be on the screen
	
	[_items removeAllObjects];
	
	NSUInteger total = [_dataSource numberOfItemsInCollectionView:self];
	for (NSUInteger i = 0; i < total; i++) {
		SSCollectionViewItem *item = [_dataSource collectionView:self itemForIndex:i];
		[_items addObject:item];
		[self addSubview:item];
	}
	
	[self setNeedsLayout];
}


- (SSCollectionViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier {
	return nil;
}


#pragma mark Setters

- (void)setDataSource:(id<SSCollectionViewDataSource>)dataSource {
	_dataSource = dataSource;
	[self reloadData];
}

@end
