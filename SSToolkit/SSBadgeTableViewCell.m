//
//  SSBadgeTableViewCell.m
//  SSToolkit
//
//  Created by Sam Soffes on 1/29/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSBadgeTableViewCell.h"
#import "SSBadgeView.h"

@implementation SSBadgeTableViewCell

#pragma mark - Accessors

@synthesize badgeView = _badgeView;


#pragma mark - UITableView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		_badgeView = [[SSBadgeView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 55.0f, 20.0f)];
		_badgeView.backgroundColor = [UIColor clearColor];
		_badgeView.badgeAlignment = SSBadgeViewAlignmentRight;
		self.accessoryView = _badgeView;
	}
	return self;
}

@end
