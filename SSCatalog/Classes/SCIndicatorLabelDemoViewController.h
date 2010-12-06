//
//  SCIndicatorLabelDemoViewController.h
//  SSCatalog
//
//  Created by Sam Soffes on 11/15/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

@class SSIndicatorLabel;

@interface SCIndicatorLabelDemoViewController : UIViewController {

	SSIndicatorLabel *_indicatorLabel;
}

+ (NSString *)title;

- (void)start:(id)sender;
- (void)stop:(id)sender;

@end
