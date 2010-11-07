//
//  SSLoadingView.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/8/09.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

/**
 @brief easy view to show loading similar to the loading screens
 in the iTunes or App Store applications. The view is intended to cover
 another view while it is loading and the removed once loading is complete.
 
 This view will automatically center the text and the activity indicator.
 */
@interface SSLoadingView : UIView {

	UIActivityIndicatorView *_activityIndicator;
	NSString *_text;
	UIFont *_font;
	UIColor *_textColor;
	UIColor *_shadowColor;
}

/**
 @brief A view that indicates loading activity to the user. (read-only)
 */
@property (nonatomic, retain, readonly) UIActivityIndicatorView *activityIndicator;

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
 */
@property (nonatomic, retain) UIColor *textColor;

/**
 @brief the color of the text shadow.
 
 Set to nil to disable drawing the shadow.
 */
@property (nonatomic, retain) UIColor *shadowColor;

@end
