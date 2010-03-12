//
//  TWMessageTableViewCellBubbleView.m
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010 Tasteful Works. All rights reserved.
//

#import "TWMessageTableViewCellBubbleView.h"
#import "UIImage+BundleImage.h"

#define kFont [UIFont systemFontOfSize:15.0]
static UILineBreakMode kLineBreakMode = UILineBreakModeWordWrap;
static CGFloat kMaxWidth = 223.0;
static CGFloat kPaddingTop = 6.0;
static CGFloat kPaddingBottom = 8.0;
static CGFloat kMarginTop = 2.0;
static CGFloat kMarginBottom = 2.0;

@implementation TWMessageTableViewCellBubbleView

@synthesize messageText;
@synthesize messageStyle;

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (UIImage *)bubbleImageForMessageStyle:(TWMessageTableViewCellMessageStyle)aMessageStyle {
	UIImage *image;
	if (aMessageStyle == TWMessageTableViewCellMessageStyleGreen) {
		image = [[UIImage imageNamed:@"images/messages-bubble-green.png" bundle:@"TWToolkit.bundle"] stretchableImageWithLeftCapWidth:17 topCapHeight:14];
	} else {
		image = [[UIImage imageNamed:@"images/messages-bubble-gray.png" bundle:@"TWToolkit.bundle"] stretchableImageWithLeftCapWidth:24 topCapHeight:14];
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


#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor colorWithRed:0.859 green:0.886 blue:0.929 alpha:1.0];
	}
	return self;
}


- (void)drawRect:(CGRect)frame {
	UIImage *bubbleImage = [[self class] bubbleImageForMessageStyle:messageStyle];
	CGSize bubbleSize = [[self class] bubbleSizeForText:messageText];
	CGRect bubbleFrame = CGRectMake((messageStyle == TWMessageTableViewCellMessageStyleGreen ? self.frame.size.width - bubbleSize.width : 0.0), kMarginTop, bubbleSize.width, bubbleSize.height);
	[bubbleImage drawInRect:bubbleFrame];
	
	CGSize textSize = [[self class] textSizeForText:messageText];
	CGRect textFrame = CGRectMake(((messageStyle == TWMessageTableViewCellMessageStyleGreen) ? (13.0 + bubbleFrame.origin.x) : 23.0), kPaddingTop + kMarginTop, textSize.width, textSize.height);
	[messageText drawInRect:textFrame withFont:kFont lineBreakMode:kLineBreakMode alignment:(messageStyle == TWMessageTableViewCellMessageStyleGreen) ? UITextAlignmentRight : UITextAlignmentLeft];
}

@end
