//
//  SSToolkitDefines.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/2/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#ifndef SSTOOLKITDEFINES
#define SSTOOLKITDEFINES

/**
 The name of the SSToolkit bundle.
 
 Mainly used for accessing images in various `UIControl`'s.
 */
extern NSString *const kSSToolkitBundleName;

/**
 `SSCollectionView` exception name for `nil` `SSCollectionViewItem` objects.
 */
extern NSString *const kSSCollectionViewNilItemExceptionName;

/**
 `SSCollectionView` exception reason for `nil` `SSCollectionViewItem` objects.
 */
extern NSString *const kSSCollectionViewNilItemExceptionReason;

/**
 `SSCollectionView` exception name for missing or invalid `SSCollectionViewItem` size.
 */
extern NSString *const SSCollectionViewInvalidItemSizeExceptionName;

/**
 `SSCollectionView` exception reason for missing or invalid `SSCollectionViewItem` size.
 */
extern NSString *const SSCollectionViewInvalidItemSizeExceptionReason;

#endif
