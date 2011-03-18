//
//  SSHUDWindow.h
//  SSToolkit
//
//  Created by Sam Soffes on 3/17/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

@interface SSHUDWindow : UIWindow {

	BOOL _showsVignette;
	BOOL _restoreDeviceOrientationNotifications;
}

@property (nonatomic, assign) BOOL showsVignette;

@end
