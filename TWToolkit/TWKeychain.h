//
//  TWKeychain.h
//  TWToolkit
//
//  Created by Sam Soffes on 5/19/10.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

enum {
	TWKeychainErrorBadArguments = -1001,
	TWKeychainErrorNoPassword = -1002
};

extern NSString *TWKeychainErrorDomain;

@interface TWKeychain : NSObject

// Class Methods
+ (TWKeychain *)defaultKeychain;
+ (NSString *)passwordForService:(NSString *)service account:(NSString *)account error:(NSError **)error;
+ (BOOL)removePasswordForService:(NSString *)service account:(NSString *)account error:(NSError **)error;
+ (BOOL)setPassword:(NSString *)password forService:(NSString *)service account:(NSString *)account error:(NSError **)error;

@end
