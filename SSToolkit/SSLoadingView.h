//
//  SSLoadingView.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

/**
 @brief easy view to show loading similar to the loading screens
 in the iTunes or App Store applications. The view is intended to cover
 another view while it is loading and the removed once loading is complete.
 
 This view will automatically center the text and the activity indicator.
 */
@interface SSLoadingView : UIView {

@private
	
	UIActivityIndicatorView *_activityIndicatorView;
	NSString *_text;
	UIFont *_font;
	UIColor *_textColor;
	UIColor *_shadowColor;
	CGSize _shadowOffset;
}

/**
 @brief A view that indicates loading activity to the user. (read-only)
 */
@property (nonatomic, retain, readonly) UIActivityIndicatorView *activityIndicatorView;

/**
 @brief The text that is displayed to the user.
 
 The default is "Loading..."
 */
@property (nonatomic, copy) NSString *text;

/**
 @brief The font of the text.
 */
@property (nonatomic, retain) UIFont *font;

/**
 @brief The color of the text.
 
 The default value is <code>[UIColor darkGrayColor]</code>.
 */
@property (nonatomic, retain) UIColor *textColor;

/**
 @brief The color of the text shadow.
 
 Set to nil to disable drawing the shadow. The default value is
 <code>[UIColor whiteColor]</code>.
 */
@property (nonatomic, retain) UIColor *shadowColor;

/**
 @brief The shadow offset (measured in points) for the text.
 
 The shadowColor must be non-nil for this property to have any effect. The default offset
 size is (0, 1), which indicates a shadow one point below the text. Text shadows are drawn
 with the specified offset and color and no blurring.
 */
@property (nonatomic, assign) CGSize shadowOffset;

@end
