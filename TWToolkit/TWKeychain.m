//
//  TWKeychain.m
//  TWToolkit
//
//  Created by Sam Soffes on 5/19/10.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWKeychain.h"
#import <Security/Security.h>

NSString *TWKeychainErrorDomain = @"com.tastefulworks.twkeychain";
static TWKeychain *kDefaultKeychain = nil;

@interface TWKeychain (PrivateMethods)
+ (NSMutableDictionary *)keychainQueryForService:(NSString *)service account:(NSString *)account;
@end

@implementation TWKeychain

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (TWKeychain *)defaultKeychain {
	if (kDefaultKeychain == nil) {
		kDefaultKeychain = [[self alloc] init];
	}
	return kDefaultKeychain;
}


+ (NSMutableDictionary *)keychainQueryForService:(NSString *)service account:(NSString *)account {
	return [NSMutableDictionary dictionaryWithObjectsAndKeys:(id)kSecClassGenericPassword, 
			(id)kSecClass, account, (id)kSecAttrAccount, 
			service, (id)kSecAttrService, 
			nil];
}


+ (NSString *)passwordForService:(NSString *)service account:(NSString *)account {
	return [self passwordForService:service account:account error:nil];
}


+ (NSString *)passwordForService:(NSString *)service account:(NSString *)account error:(NSError **)error {
	OSStatus status = TWKeychainErrorBadArguments;
	NSString *result = nil;
	
	if (0 < [service length] && 0 < [account length]) {
		CFDataRef passwordData = NULL;
		NSMutableDictionary *keychainQuery = [self keychainQueryForService:service account:account];
		[keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
		[keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
		
		OSStatus status = SecItemCopyMatching((CFDictionaryRef)keychainQuery,
											  (CFTypeRef *)&passwordData);
		if (status == noErr && 0 < [(NSData *)passwordData length]) {
			result = [[[NSString alloc] initWithData:(NSData *)passwordData
											encoding:NSUTF8StringEncoding] autorelease];
		}
		
		if (passwordData != NULL) {
			CFRelease(passwordData);
		}
	}
	
	if (status != noErr && error != NULL) {
		*error = [NSError errorWithDomain:TWKeychainErrorDomain code:status userInfo:nil];
	}
	
	return result;
}


+ (BOOL)deletePasswordForService:(NSString *)service account:(NSString *)account {
	return [self deletePasswordForService:service account:account error:nil];
}


+ (BOOL)deletePasswordForService:(NSString *)service account:(NSString *)account error:(NSError **)error {
	OSStatus status = TWKeychainErrorBadArguments;
	if (0 < [service length] && 0 < [account length]) {
		NSMutableDictionary *keychainQuery = [self keychainQueryForService:service account:account];
		status = SecItemDelete((CFDictionaryRef)keychainQuery);
	}
	
	if (status != noErr && error != NULL) {
		*error = [NSError errorWithDomain:TWKeychainErrorDomain code:status userInfo:nil];
	}
	
	return status == noErr;
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)service account:(NSString *)account {
	return [self setPassword:password forService:service account:account error:nil];
}


+ (BOOL)setPassword:(NSString *)password forService:(NSString *)service account:(NSString *)account error:(NSError **)error {
	OSStatus status = TWKeychainErrorBadArguments;
	if (0 < [service length] && 0 < [account length]) {
		[self deletePasswordForService:service account:account];
		if (0 < [password length]) {
			NSMutableDictionary *keychainQuery = [self keychainQueryForService:service account:account];
			NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
			[keychainQuery setObject:passwordData forKey:(id)kSecValueData];
			status = SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
		}
	}
	
	if (status != noErr && error != NULL) {
		*error = [NSError errorWithDomain:TWKeychainErrorDomain code:status userInfo:nil];
	}
	
	return status == noErr;
}

@end
