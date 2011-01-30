//
//  SSBadgeTableViewCell.h
//  SSToolkit
//
//  Created by Sam Soffes on 1/29/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@class SSBadgeView;

@interface SSBadgeTableViewCell : UITableViewCell {

	SSBadgeView *_badgeView;
}

@property (nonatomic, retain, readonly) SSBadgeView *badgeView;

@end
