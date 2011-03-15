//
//  SSCollectionViewTableViewCell.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/10/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@class SSCollectionView;

@interface SSCollectionViewTableViewCell : UITableViewCell {

@private
	
	CGSize _itemSize;
	CGFloat _itemSpacing;
	NSArray *_items;
	SSCollectionView *_collectionView;
}

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, assign) SSCollectionView *collectionView;

- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier;

@end
