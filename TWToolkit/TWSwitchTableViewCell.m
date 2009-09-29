//
//  TWSwitchTableViewCell.m
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWSwitchTableViewCell.h"

@implementation TWSwitchTableViewCell

@synthesize switchView;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[switchView release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIView
#pragma mark -

- (void)layoutSubviews {
	[super layoutSubviews];
	switchView.frame = CGRectMake(self.contentView.frame.size.width - 104.0, round((self.contentView.frame.size.height - 27.0) / 2.0), 94.0, 27.0);
}


#pragma mark -
#pragma mark UITableViewCell
#pragma mark -

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
		
		// Defaults
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		// Switch
		switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:switchView];
	}
	return self;
}


- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
	[super setAccessoryType:UITableViewCellAccessoryNone];
}


- (void)setSelectionStyle:(UITableViewCellSelectionStyle)style {
	[super setSelectionStyle:UITableViewCellSelectionStyleNone];
}

@end
