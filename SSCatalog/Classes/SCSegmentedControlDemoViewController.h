//
//  SCSegmentedControlDemoViewController.h
//  SSCatalog
//
//  Created by Sam Soffes on 2/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@class SSSegmentedControl;

@interface SCSegmentedControlDemoViewController : UIViewController {
 
@private	

	UISegmentedControl *_systemSegmentedControl;
	SSSegmentedControl *_customSegmentedControl;
}

+ (NSString *)title;

- (void)valueChanged:(id)sender;

@end
