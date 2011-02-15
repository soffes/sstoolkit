//
//  SSAddressBarTextFieldBackgroundView.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/8/11.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

@class SSAddressBarTextFieldBackgroundViewInnerView;

@interface SSAddressBarTextFieldBackgroundView : UIView {
	
	BOOL _loading;
	NSTimer *_moveTimer;
	SSAddressBarTextFieldBackgroundViewInnerView *_innerView;
}

@property (nonatomic, assign, getter=isLoading) BOOL loading;

@end
