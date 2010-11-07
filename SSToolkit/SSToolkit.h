//
//  SSToolkit.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/19/09.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

/**
 @mainpage SSToolkit makes life easier.
 
 The goal of SSToolkit is to eliminate solving simple problems over and over again while
 staying very light weight. You can pick and choose the parts that you like and disregard
 the rest.
 
 @section Links
 
 @li <a href="http://github.com/samsoffes/sstoolkit">Source code</a>
 @li <a href="http://sstoolk.it/documentation">Documentation</a>
 @li <a herf="https://github.com/samsoffes/sstoolkit/issues/labels/Bug">Known bugs</a>
 @li <a href="https://github.com/samsoffes/sstoolkit/issues/labels/Enhancement">Future features</a>

 */

// This setting of 1 is best if you copy the source into your project. 
// The build transforms the 1 to a 0 when building the framework and static lib.

#if 1

// Views
#import <SSToolkit/SSCollectionView.h>
#import <SSToolkit/SSCollectionViewItem.h>
#import <SSToolkit/SSGradientView.h>
#import <SSToolkit/SSHUDView.h>
#import <SSToolkit/SSIndicatorLabel.h>
#import <SSToolkit/SSLabel.h>
#import <SSToolkit/SSLineView.h>
#import <SSToolkit/SSLoadingView.h>
#import <SSToolkit/SSPieProgressView.h>
#import <SSToolkit/SSWebView.h>

// Controls
#import <SSToolkit/SSTextField.h>
#import <SSToolkit/SSTextView.h>

// View Controllers
#import <SSToolkit/SSCollectionViewController.h>
#import <SSToolkit/SSModalViewController.h>
#import <SSToolkit/SSNavigationController.h>
#import <SSToolkit/SSPickerViewController.h>
#import <SSToolkit/SSTableViewController.h>
#import <SSToolkit/SSViewController.h>

// Cells
#import <SSToolkit/SSTableViewCell.h>

// Misc
#import <SSToolkit/SSDrawingMacros.h>
#import <SSToolkit/SSConcurrentOperation.h>
#import <SSToolkit/SSKeychain.h>

#else

// Views
#import "SSCollectionView.h"
#import "SSCollectionViewItem.h"
#import "SSGradientView.h"
#import "SSHUDView.h"
#import "SSIndicatorLabel.h"
#import "SSLabel.h"
#import "SSLineView.h"
#import "SSLoadingView.h"
#import "SSPieProgressView.h"
#import "SSWebView.h"

// Controls
#import "SSTextField.h"
#import "SSTextView.h"

// View Controllers
#import "SSCollectionViewController.h"
#import "SSModalViewController.h"
#import "SSNavigationController.h"
#import "SSPickerViewController.h"
#import "SSTableViewController.h"
#import "SSViewController.h"

// Cells
#import "SSTableViewCell.h"

// Misc
#import "SSDrawingMacros.h"
#import "SSConcurrentOperation.h"
#import "SSKeychain.h"

#endif
