//
//  TCTwitterDemoViewController.h
//  TWCatalog
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import <TWToolkit/TWToolkit.h>

@interface TCTwitterDemoViewController : UIViewController <TWTwitterOAuthViewControllerDelegate, UIAlertViewDelegate> {

}

+ (TCTwitterDemoViewController *)setup;

- (void)authorize:(id)sender;

@end
