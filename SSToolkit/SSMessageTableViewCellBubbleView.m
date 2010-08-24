//
//  SSMessageTableViewCellBubbleView.m
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSMessageTableViewCellBubbleView.h"
#import "UIImage+SSToolkitAdditions.h"

#define kFont [UIFont systemFontOfSize:15.0]
static UILineBreakMode kLineBreakMode = UILineBreakModeWordWrap;
static CGFloat kMaxWidth = 223.0; // TODO: Make dynamic
static CGFloat kPaddingTop = 6.0;
static CGFloat kPaddingBottom = 8.0;
static CGFloat kMarginTop = 2.0;
static CGFloat kMarginBottom = 2.0;

@implementation SSMessageTableViewCellBubbleView

@synthesize messageText;
@synthesize messageStyle;

#pragma mark Class Methods

+ (UIImage *)bubbleImageForMessageStyle:(SSMessageTableViewCellMessageStyle)aMessageStyle {
	UIImage *image;
	if (aMessageStyle == SSMessageTableViewCellMessageStyleGreen) {
		image = [[UIImage imageNamed:@"images/SSMessageTableViewCellBackgroundGreen.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:17 topCapHeight:14];
	} else {
		image = [[UIImage imageNamed:@"images/SSMessageTableViewCellBackgroundGray.png" bundle:@"SSToolkit.bundle"] stretchableImageWithLeftCapWidth:24 topCapHeight:14];
	}
	return image;
}


+ (CGSize)textSizeForText:(NSString *)text {
	CGSize maxSize = CGSizeMake(kMaxWidth - 38.0, 1000.0);
	return [text sizeWithFont:kFont constrainedToSize:maxSize lineBreakMode:kLineBreakMode];
}


+ (CGSize)bubbleSizeForText:(NSString *)text {
	CGSize textSize = [self textSizeForText:text];
	return CGSizeMake(textSize.width + 38.0, textSize.height + kPaddingTop + kPaddingBottom);
}


+ (CGFloat)cellHeightForText:(NSString *)text {
	return [self bubbleSizeForText:text].height + kMarginTop + kMarginBottom;
}

#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor colorWithRed:0.859 green:0.886 blue:0.929 alpha:1.0];
	}
	return self;
}


- (void)drawRect:(CGRect)frame {
	UIImage *bubbleImage = [[self class] bubbleImageForMessageStyle:messageStyle];
	CGSize bubbleSize = [[self class] bubbleSizeForText:messageText];
	CGRect bubbleFrame = CGRectMake((messageStyle == SSMessageTableViewCellMessageStyleGreen ? self.frame.size.width - bubbleSize.width : 0.0), kMarginTop, bubbleSize.width, bubbleSize.height);
	[bubbleImage drawInRect:bubbleFrame];
	
	CGSize textSize = [[self class] textSizeForText:messageText];
	CGRect textFrame = CGRectMake(((messageStyle == SSMessageTableViewCellMessageStyleGreen) ? (13.0 + bubbleFrame.origin.x) : 23.0), kPaddingTop + kMarginTop, textSize.width, textSize.height);
	[messageText drawInRect:textFrame withFont:kFont lineBreakMode:kLineBreakMode alignment:(messageStyle == SSMessageTableViewCellMessageStyleGreen) ? UITextAlignmentRight : UITextAlignmentLeft];
}

@end
