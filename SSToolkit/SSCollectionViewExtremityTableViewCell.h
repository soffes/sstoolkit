//
//  SSCollectionViewExtremityTableViewCell.h
//  SSToolkit
//
//  Created by Sam Soffes on 5/27/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@interface SSCollectionViewExtremityTableViewCell : UITableViewCell {

@private
	
	UIView *_extrimityView;
}

@property (nonatomic, retain) UIView *extrimityView;

- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier;

@end
