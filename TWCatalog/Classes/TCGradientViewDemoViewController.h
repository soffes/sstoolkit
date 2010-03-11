//
//  TCGradientViewDemoViewController.h
//  TWCatalog
//
//  Created by Sam Soffes on 10/27/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@class TWGradientView;

@interface TCGradientViewDemoViewController : UIViewController {

	TWGradientView *gradientView;
}

+ (NSString *)title;
+ (id)setup;

- (void)changeColor:(id)sender;

@end
