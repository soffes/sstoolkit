//
//  TWURLRequestParameter.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequestParameter.h"

@implementation TWURLRequestParameter

@synthesize name, value;

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (id)requestParameterWithName:(NSString *)aName value:(NSString *)aValue  {
	return [[[TWURLRequestParameter alloc] initWithName:aName value:aValue] autorelease];
}

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[name release];
	[value release];
	[super dealloc];
}


#pragma mark -
#pragma mark TWURLRequestParameter
#pragma mark -

- (id)initWithName:(NSString *)aName value:(NSString *)aValue {
    if (self = [super init]) {
		self.name = aName;
		self.value = aValue;
	}
    return self;
}


- (NSString *)URLEncodedName  {
	return [self.name URLEncodedString];
}


- (NSString *)URLEncodedValue  {
    return [self.value URLEncodedString];
}


- (NSString *)URLEncodedNameValuePair  {
    return [NSString stringWithFormat:@"%@=%@", [self URLEncodedName], [self URLEncodedValue]];
}

@end
