//
//  SSAddressBarTextFieldBackgroundView.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/8/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@class SSAddressBarTextFieldBackgroundViewInnerView;

@interface SSAddressBarTextFieldBackgroundView : UIView {
	
@private
	
	BOOL _loading;
	SSAddressBarTextFieldBackgroundViewInnerView *_innerView;
}

@property (nonatomic, assign, getter=isLoading) BOOL loading;

@end
