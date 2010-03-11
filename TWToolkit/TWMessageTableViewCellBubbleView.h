//
//  TWMessageTableViewCellBubbleView.h
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

#import "TWMessageTableViewCell.h"

@interface TWMessageTableViewCellBubbleView : UIView {

	NSString *messageText;
	TWMessageTableViewCellMessageStyle messageStyle;
}

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, assign) TWMessageTableViewCellMessageStyle messageStyle;

+ (UIImage *)bubbleImageForMessageStyle:(TWMessageTableViewCellMessageStyle)aMessageStyle;
+ (CGSize)textSizeForText:(NSString *)text;
+ (CGSize)bubbleSizeForText:(NSString *)text;
+ (CGFloat)cellHeightForText:(NSString *)text;

@end
