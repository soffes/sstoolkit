//
//  SCPickerDemoViewController.h
//  SSCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Sam Soffes, Inc. All rights reserved.
//

@interface SCPickerDemoViewController : UITableViewController {
	
	NSString *_selectedAbbreviation;
}

@property (nonatomic, retain) NSString *selectedAbbreviation;

+ (NSString *)title;

@end
