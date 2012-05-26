//
//  UIApplication+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/20/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `UIApplication` for various common tasks.
 */
@interface UIApplication (SSToolkitAdditions)

///------------------
/// @name Directories
///------------------

/**
 Returns the file URL of the documents directory.
 */
@property (nonatomic, strong, readonly) NSURL *documentsDirectoryURL;

/**
 Returns the file URL of the caches directory.
 */
@property (nonatomic, strong, readonly) NSURL *cachesDirectoryURL;

/**
 Returns the file URL of the downloads directory.
 */
@property (nonatomic, strong, readonly) NSURL *downloadsDirectoryURL;

/**
 Returns the file URL of the library directory.
 */
@property (nonatomic, strong, readonly) NSURL *libraryDirectoryURL;

/**
 Returns the file URL of the application support directory.
 */
@property (nonatomic, strong, readonly) NSURL *applicationSupportDirectoryURL;


///----------------
/// @name Utilities
///----------------

/**
 Aggregates calls to settings `networkActivityIndicatorVisible` to avoid flashing of the indicator in the status bar.
 Simply use `setNetworkActivity:` instead of `setNetworkActivityIndicatorVisible:`.
 
 Specify `YES` if the application should show network activity and `NO` if it should not. The default value is `NO`.
 A spinning indicator in the status bar shows network activity. The application may explicitly hide or show this
 indicator.
 
 @param inProgress A Boolean value that turns an indicator of network activity on or off.
 */
- (void)setNetworkActivity:(BOOL)inProgress;

/** Checks for pirated application indicators.
 
 This isn't bulletproof, but should catch a lot of cases.
 
 Thanks Marco Arment: <http://twitter.com/marcoarment/status/27965461020>
 
 @return `YES` if the application may be pirated. `NO` if it is probably not pirated.
 */
- (BOOL)isPirated;

@end
