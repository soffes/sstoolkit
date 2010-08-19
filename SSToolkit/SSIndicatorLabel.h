//
//  SSIndicatorLabel.h
//  SSToolkit
//
//  Created by Sam Soffes on 7/13/10.
//  Copyright 2010 Sam Soffes, Inc. All rights reserved.
//

@interface SSIndicatorLabel : UIView {

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
