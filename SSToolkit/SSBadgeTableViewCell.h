//
//  SSBadgeTableViewCell.h
//  SSToolkit
//
//  Created by Sam Soffes on 1/29/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@class SSBadgeView;

/**
 @brief Table view cell that displays a badge as its accessory.
 */
@interface SSBadgeTableViewCell : UITableViewCell {

@private
	
	SSBadgeView *_badgeView;
}

/**
 @brief A view that indicates some status to the user. (read-only)
 */
@property (nonatomic, retain, readonly) SSBadgeView *badgeView;

@end
