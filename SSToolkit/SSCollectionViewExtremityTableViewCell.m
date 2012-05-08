//
//  SSCollectionViewExtremityTableViewCell.m
//  SSToolkit
//
//  Created by Sam Soffes on 5/27/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSCollectionViewExtremityTableViewCell.h"

@implementation SSCollectionViewExtremityTableViewCell

#pragma mark - Accessors

@synthesize extrimityView = _extrimityView;

- (void)setExtrimityView:(UIView *)view {
	[_extrimityView removeFromSuperview];
	_extrimityView = view;
	[self addSubview:_extrimityView];
	[self setNeedsLayout];
}


#pragma mark - UIView

- (void)layoutSubviews {
	_extrimityView.frame = self.bounds;
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
	}
	return self;
}


- (void)prepareForReuse {
	[super prepareForReuse];
	self.extrimityView = nil;
}


#pragma mark - Initializer

- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aReuseIdentifier];
	return self;
}

@end
