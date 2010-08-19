//
//  SSTextView.h
//  SSToolkit
//
//  Created by Sam Soffes on 8/18/10.
//  Copyright 2010 Sam Soffes, Inc. All rights reserved.
//

@interface SSTextView : UITextView {
	
	NSString *_placeholder;
	UIColor *_placeholderColor;
	
	BOOL _shouldDrawPlaceholder;
}

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@end
