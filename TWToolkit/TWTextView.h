//
//  TWTextView.h
//  TWToolkit
//
//  Created by Sam Soffes on 8/18/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

@interface TWTextView : UITextView {
	
	NSString *_placeholder;
	UIColor *_placeholderColor;
	
	BOOL _shouldDrawPlaceholder;
}

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@end
