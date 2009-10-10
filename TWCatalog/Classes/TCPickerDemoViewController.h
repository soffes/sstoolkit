//
//  TCPickerDemoViewController.h
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface TCPickerDemoViewController : UITableViewController {
	
	NSString *selectedAbbreviation;
}

@property (nonatomic, retain) NSString *selectedAbbreviation;

+ (TCPickerDemoViewController *)setup;

@end
