//
//  TWURLRequestParameter.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequestParameter.h"

@implementation TWURLRequestParameter

@synthesize key, value;

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (id)requestParameterWithKey:(NSString *)aKey value:(NSString *)aValue  {
	return [[[TWURLRequestParameter alloc] initWithKey:aKey value:aValue] autorelease];
}

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[key release];
	[value release];
	[super dealloc];
}


#pragma mark -
#pragma mark TWURLRequestParameter
#pragma mark -

- (id)initWithKey:(NSString *)aKey value:(NSString *)aValue {
    if (self = [super init]) {
		self.key = aKey;
		self.value = aValue;
	}
    return self;
}


- (NSString *)URLEncodedKey  {
	return [self.key URLEncodedString];
}


- (NSString *)URLEncodedValue  {
    return [self.value URLEncodedString];
}


- (NSString *)URLEncodedKeyValuePair  {
    return [NSString stringWithFormat:@"%@=%@", [self URLEncodedKey], [self URLEncodedValue]];
}

@end
