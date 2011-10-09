//
//  SSAddressBarTextField.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/8/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "SSTextField.h"

@interface SSAddressBarTextField : SSTextField

@property (nonatomic, assign, getter=isLoading) BOOL loading;
@property (nonatomic, retain) UIButton *reloadButton;
@property (nonatomic, retain) UIButton *stopButton;

@end
