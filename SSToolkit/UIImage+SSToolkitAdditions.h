//
//  UIImage+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 11/17/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

/**
 Provides extensions to `UIImage` for various common tasks.
 */
@interface UIImage (SSToolkitAdditions)

///-------------------
/// @name Initializing
///-------------------

/**
 Returns the image object associated with the specified filename.
 
 This method looks in the system caches for an image object with the specified name and returns that object if it
 exists. If a matching image object is not already in the cache, this method loads the image data from the specified
 file, caches it, and then returns the resulting object.
 
 @param imageName The name of the file. If this is the first time the image is being loaded, the method looks for an image
 with the specified name in the specified bundle.
 
 @param bundleName The name of the bundle to search for the image. Specify `nil` to use the main bundle.
 
 @return The image object for the specified file, or `nil` if the method could not find the specified image.
 */
+ (UIImage *)imageNamed:(NSString *)imageName bundleName:(NSString *)bundleName;


///---------------
/// @name Cropping
///---------------

/**
 Creates and returns a new cropped image object.
 
 @param rect A rectangle whose coordinates specify the area to create an image from in points.
 
 @return A new cropped image object.
 */
- (UIImage *)imageCroppedToRect:(CGRect)rect;

/**
 Creates and returns a new image object that is cropped to the center of the image.
 
 The length of the sides of square are the length of the shortest side of the image.
 
 @return A new square image object.
 */
- (UIImage *)squareImage;


///-----------------
/// @name Stretching
///-----------------

/**
 The right horizontal end-cap size. (read-only)
 
 End caps specify the portion of an image that should not be resized when an image is stretched. This technique is used
 to implement buttons and other resizable image-based interface elements. When a button with end caps is resized, the
 resizing occurs only in the middle of the button, in the region between the end caps. The end caps themselves keep
 their original size and appearance.
 
 This property specifies the size of the left end cap. The middle (stretchable) portion is assumed to be `1` pixel wide.
 
 By default, this property is set to `0`, which indicates that the image does not use end caps and the entire image is
 subject to stretching. To create a new image with a nonzero value for this property, use the
 `stretchableImageWithLeftCapWidth:topCapHeight:` method.
 */
@property (nonatomic, assign, readonly) NSInteger rightCapWidth;

/**
 The bottom vertical end-cap size. (read-only)
 
 End caps specify the portion of an image that should not be resized when an image is stretched. This technique is used
 to implement buttons and other resizable image-based interface elements. When a button with end caps is resized, the
 resizing occurs only in the middle of the button, in the region between the end caps. The end caps themselves keep
 their original size and appearance.
 
 This property specifies the size of the top end cap. The middle (stretchable) portion is assumed to be `1` pixel wide.
 
 By default, this property is set to `0`, which indicates that the image does not use end caps and the entire image is
 subject to stretching. To create a new image with a nonzero value for this property, use the
 `stretchableImageWithLeftCapWidth:topCapHeight:` method.
 */
@property (nonatomic, assign, readonly) NSInteger bottomCapHeight;

@end
