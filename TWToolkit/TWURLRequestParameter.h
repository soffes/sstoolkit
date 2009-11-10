//
//  TWURLRequestParameter.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "NSString+URLEncoding.h"

@interface TWURLRequestParameter : NSObject {

@protected
    NSString *name;
    NSString *value;
}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *value;

+ (id)requestParameterWithName:(NSString *)aName value:(NSString *)aValue;

- (id)initWithName:(NSString *)aName value:(NSString *)aValue;
- (NSString *)URLEncodedName;
- (NSString *)URLEncodedValue;
- (NSString *)URLEncodedNameValuePair;

@end
