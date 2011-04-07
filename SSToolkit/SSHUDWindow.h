//
//  SSHUDWindow.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@interface SSHUDWindow : UIWindow {

@private
	
	BOOL _hidesVignette;
}

@property (nonatomic, assign) BOOL hidesVignette;

+ (SSHUDWindow *)defaultWindow;

@end
