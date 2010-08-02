//
//  TWIndicatorLabel.h
//  TWToolkit
//
//  Created by Sam Soffes on 7/13/10.
//  Copyright 2010 Tasteful Works, Inc. All rights reserved.
//

@interface TWIndicatorLabel : UIView {

	UILabel *_label;
	UIActivityIndicatorView *_indicator;
	BOOL _loading;
}

@property (nonatomic, retain, readonly) UILabel *label;
@property (nonatomic, retain, readonly) UIActivityIndicatorView *indicator;
@property (nonatomic, assign, getter=isLoading) BOOL loading;

+ (CGSize)indicatorSize;
+ (CGFloat)padding;

- (void)startWithText:(NSString *)text;
- (void)completeWithText:(NSString *)text;

@end
