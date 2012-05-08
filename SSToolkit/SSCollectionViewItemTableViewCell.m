//
//  SSCollectionViewItemTableViewCell.m
//  SSToolkit
//
//  Created by Sam Soffes on 3/10/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewItemTableViewCell.h"
#import "SSCollectionViewItem.h"
#import "SSCollectionView.h"
#import "SSCollectionViewInternal.h"

@implementation SSCollectionViewItemTableViewCell

#pragma mark - Accessors

@synthesize itemSize = _itemSize;
@synthesize itemSpacing = _itemSpacing;

@synthesize items = _items;

- (void)setItems:(NSArray *)someItems {
	[_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
	_items = someItems;
	
	if (_items == nil) {
		return;
	}
	
	[_items enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		[self addSubview:(UIView *)object];
	}];
	
	[self setNeedsLayout];
}

@synthesize collectionView = _collectionView;


#pragma mark - NSObject

- (void)dealloc {
	self.collectionView = nil;
	self.items = nil;
}


#pragma mark - UIView

- (void)layoutSubviews {
	__block CGFloat x = _itemSpacing;
	
	[_items enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
		SSCollectionViewItem *item = (SSCollectionViewItem *)object;
		
		item.frame = CGRectMake(x, 0.0f, _itemSize.width, _itemSize.height);
		x += _itemSize.width + _itemSpacing;
	}];
}


#pragma mark - UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
		self.backgroundView.hidden = YES;
		self.selectedBackgroundView.hidden = YES;
		self.contentView.hidden = YES;
		self.textLabel.hidden = YES;
		self.detailTextLabel.hidden = YES;
		self.imageView.hidden = YES;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		_itemSize = CGSizeZero;
		_itemSpacing = 0.0f;
	}
	return self;
}


- (void)prepareForReuse {
	[super prepareForReuse];
	[self.collectionView _reuseItems:_items];
	self.items = nil;
}


#pragma mark - Initializer

- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aReuseIdentifier];
	return self;
}

@end
