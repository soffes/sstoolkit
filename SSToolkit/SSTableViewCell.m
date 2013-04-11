//
//  SSTableViewCell.m
//  SSToolkit
//
//  Created by Eliezer Talón on 11/04/13.
//  Copyright (c) 2013 Sam Soffes. All rights reserved.
//

#import "SSTableViewCell.h"

@implementation SSTableViewCell

#pragma mark - Cell factory

+ (instancetype)cellForTableView:(UITableView *)tableView {
	NSString *cellID = [self cellIdentifier];
	SSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
	if (cell == nil) {
		cell = [[self alloc] initWithCellIdentifier:cellID];
	}
	return cell;
}

+ (NSString *)cellIdentifier {
	return NSStringFromClass([self class]);
}

- (instancetype)initWithCellIdentifier:(NSString *)cellID {
	return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
}

@end
