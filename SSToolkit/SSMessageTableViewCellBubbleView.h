//
//  SSMessageTableViewCellBubbleView.h
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSMessageTableViewCell.h"

@interface SSMessageTableViewCellBubbleView : UIView {

	NSString *messageText;
	SSMessageTableViewCellMessageStyle messageStyle;
}

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, assign) SSMessageTableViewCellMessageStyle messageStyle;

+ (UIImage *)bubbleImageForMessageStyle:(SSMessageTableViewCellMessageStyle)aMessageStyle;
+ (CGSize)textSizeForText:(NSString *)text;
+ (CGSize)bubbleSizeForText:(NSString *)text;
+ (CGFloat)cellHeightForText:(NSString *)text;

@end
