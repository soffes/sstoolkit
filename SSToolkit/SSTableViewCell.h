//
//  SSTableViewCell.h
//  SSToolkit
//
//  Created by Sam Soffes on 8/16/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//
//	Based on ABTableViewCell by Loren Brichter
//

@interface SSTableViewCell : UITableViewCell {
	
	UIView *_cellView;
}

- (void)drawContentView:(CGRect)rect;

@end
