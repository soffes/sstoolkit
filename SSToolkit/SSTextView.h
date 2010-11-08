//
//  SSTextView.h
//  SSToolkit
//
//  Created by Sam Soffes on 8/18/10.
//  Copyright 2009-2010 Sam Soffes. All rights reserved.
//

/**
 @brief UITextView subclass that adds placeholder support like
 UITextField has.
 */
@interface SSTextView : UITextView {
	
	NSString *_placeholder;
	UIColor *_placeholderColor;

@protected
	
	BOOL _shouldDrawPlaceholder;
}

/**
 @brief The string that is displayed when there is no other text in the text view.
 
 The default value is nil.
 */
@property (nonatomic, retain) NSString *placeholder;

/**
 @brief The color of the placeholder.
 
 The default is [UIColor lightGrayColor].
 */
@property (nonatomic, retain) UIColor *placeholderColor;

@end
