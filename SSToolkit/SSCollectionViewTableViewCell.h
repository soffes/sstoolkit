//
//  SSCollectionViewTableViewCell.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/10/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@interface SSCollectionViewTableViewCell : UITableViewCell {

@private
	
	CGSize _itemSize;
	CGFloat _leftMargin;
	CGFloat _itemSpacing;
	
	NSArray *_items;
}

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, retain) NSArray *items;

- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier;

@end
