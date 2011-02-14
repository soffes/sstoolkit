//
//  UIDevice_MKAdditions.h
//  DeviceHelper
//
//  Created by Mugunth Kumar on 15-Aug-10.
//  Copyright 2010 Steinlogic. All rights reserved.
//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	if you are re-publishing after editing, please retain the above copyright notices

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreMotion/CoreMotion.h>

@interface UIDevice (MKAdditions)  {

}

- (BOOL) isSimulator; // by Sam Soffes
- (BOOL) microphoneAvailable;
- (void) vibrateWithSound;
- (void) vibrateWithoutSound;

- (BOOL) doesPhotoLibraryHavePictures;
- (BOOL) doesCameraRollHavePictures;

- (BOOL) cameraAvailable;
- (BOOL) videoCameraAvailable;
- (BOOL) frontCameraAvailable;
- (BOOL) cameraFlashAvailable;

- (BOOL) canSendEmail;
- (BOOL) canSendSMS;
- (BOOL) canMakePhoneCalls;

- (BOOL) multitaskingCapable;
- (BOOL) retinaDisplayCapable;

- (BOOL) compassAvailable;
- (BOOL) gyroscopeAvailable;
@end
