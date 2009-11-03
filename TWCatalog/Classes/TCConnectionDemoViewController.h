//
//  TCConnectionDemoViewController.h
//  TWCatalog
//
//  Created by Sam Soffes on 10/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWToolkit/TWConnection.h"

@interface TCConnectionDemoViewController : UIViewController<TWConnectionDelegate> {

	UITextView *outputView;
}

+ (TCConnectionDemoViewController *)setup;

- (IBAction)refresh:(id)sender;

@end
