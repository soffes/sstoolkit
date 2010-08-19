//
//  SSTableViewCell.m
//  SSToolkit
//
//  Created by Sam Soffes on 8/16/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSTableViewCell.h"

@interface SSTableViewCellView : UIView
@end

@implementation SSTableViewCellView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	[(SSTableViewCell *)[self superview] drawContentView:rect];
}

@end


@implementation SSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.contentView.hidden = YES;
		self.backgroundView.hidden = YES;
		self.textLabel.hidden = YES;
		self.detailTextLabel.hidden = YES;
		self.imageView.hidden = YES;
		
		_cellView = [[SSTableViewCellView alloc] initWithFrame:CGRectZero];
		[self addSubview:_cellView];
		[self bringSubviewToFront:_cellView];
		[_cellView release];
    }
    return self;
}


- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[_cellView setNeedsDisplay];
}


- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	
	CGRect bounds = [self bounds];
	bounds.size.height -= 1;
	_cellView.frame = bounds;
	[self setNeedsDisplay];
}


- (void)drawContentView:(CGRect)rect {
	// Subclasses should implement this
}

@end
