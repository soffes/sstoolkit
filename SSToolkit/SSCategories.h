//
//  SSCategories.h
//  SSToolkit
//
//  Created by Sam Soffes on 9/17/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

// This setting of 1 is best if you copy the source into your project. 
// The build transforms the 1 to a 0 when building the framework and static lib.

#if 1

// Foundation
#import "NSArray+SSToolkitAdditions.h"
#import "NSData+SSToolkitAdditions.h"
#import "NSDate+SSToolkitAdditions.h"
#import "NSDictionary+SSToolkitAdditions.h"
#import "NSString+SSToolkitAdditions.h"
#import "NSURL+SSToolkitAdditions.h"

// UIKit
#import "UIApplication+SSToolkitAdditions.h"
#import "UIColor+SSToolkitAdditions.h"
#import "UIControl+SSToolkitAdditions.h"
#import "UIDevice+SSToolkitAdditions.h"
#import "UIImage+SSToolkitAdditions.h"
#import "UIScreen+SSToolkitAdditions.h"
#import "UIScrollView+SSToolkitAdditions.h"
#import "UIView+SSToolkitAdditions.h"
#import "UIViewController+SSToolkitAdditions.h"

#else

// Foundation
#import <SSToolkit/NSArray+SSToolkitAdditions.h>
#import <SSToolkit/NSData+SSToolkitAdditions.h>
#import <SSToolkit/NSDate+SSToolkitAdditions.h>
#import <SSToolkit/NSDictionary+SSToolkitAdditions.h>
#import <SSToolkit/NSString+SSToolkitAdditions.h>
#import <SSToolkit/NSURL+SSToolkitAdditions.h>

// UIKit
#import <SSToolkit/UIApplication+SSToolkitAdditions.h>
#import <SSToolkit/UIColor+SSToolkitAdditions.h>
#import <SSToolkit/UIControl+SSToolkitAdditions.h>
#import <SSToolkit/UIDevice+SSToolkitAdditions.h>
#import <SSToolkit/UIImage+SSToolkitAdditions.h>
#import <SSToolkit/UIScreen+SSToolkitAdditions.h>
#import <SSToolkit/UIScrollView+SSToolkitAdditions.h>
#import <SSToolkit/UIView+SSToolkitAdditions.h>
#import <SSToolkit/UIViewController+SSToolkitAdditions.h>

#endif
