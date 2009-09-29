//
//  TWSwitchTableViewCell.h
//  TWToolkit
//
//  Created by Sam Soffes on 9/29/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWSwitchTableViewCell : UITableViewCell {

	UISwitch *switchView;
}

@property (nonatomic, retain, readonly) UISwitch *switchView;

@end
