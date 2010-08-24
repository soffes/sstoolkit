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
@synthesize backgroundView = _backgroundView;
@synthesize collectionHeaderView = _collectionHeaderView;
@synthesize collectionFooterView = _collectionFooterView;
@synthesize maxNumberOfRows = _maxNumberOfRows;
@synthesize maxNumberOfColumns = _maxNumberOfColumns;
@synthesize minNumberOfRows = _minNumberOfRows;
@synthesize minNumberOfColumns = _minNumberOfColumns;
@synthesize minItemSize = _minItemSize;
@synthesize maxItemSize = _maxItemSize;
@synthesize allowsSelection = _allowsSelection;

#pragma mark NSObject

- (void)dealloc {
	[_backgroundView release];
	[_collectionHeaderView release];
	[_collectionFooterView release];
	[super dealloc];
}

#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		_minNumberOfRows = 0;
		_maxNumberOfRows = 0;
		_minNumberOfColumns = 0;
		_maxNumberOfColumns = 0;
		
		_allowsSelection = YES;
    }
    return self;
}

#pragma mark SSCollectionView

- (void)reloadData {
	
}

@end
