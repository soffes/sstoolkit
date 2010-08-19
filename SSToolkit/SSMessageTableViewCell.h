//
//  SSMessageTableViewCell.h
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

typedef enum {
	SSMessageTableViewCellMessageStyleGray = 0,
	SSMessageTableViewCellMessageStyleGreen = 1
} SSMessageTableViewCellMessageStyle;

@class SSMessageTableViewCellBubbleView;

@interface SSMessageTableViewCell : UITableViewCell {

	SSMessageTableViewCellBubbleView *bubbleView;
}

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, assign) SSMessageTableViewCellMessageStyle messageStyle;

@end
