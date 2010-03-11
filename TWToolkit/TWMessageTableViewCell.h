//
//  TWMessageTableViewCell.h
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

typedef enum {
	TWMessageTableViewCellMessageStyleGray = 0,
	TWMessageTableViewCellMessageStyleGreen = 1
} TWMessageTableViewCellMessageStyle;

@class TWMessageTableViewCellBubbleView;

@interface TWMessageTableViewCell : UITableViewCell {

	TWMessageTableViewCellBubbleView *bubbleView;
}

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, assign) TWMessageTableViewCellMessageStyle messageStyle;

@end
