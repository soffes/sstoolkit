//
//  TWURLRequestParameter.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

@interface TWURLRequestParameter : NSObject {
	
    NSString *key;
    NSString *value;
}

@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *value;

+ (id)requestParameterWithKey:(NSString *)aKey value:(NSString *)aValue;

- (id)initWithKey:(NSString *)aKey value:(NSString *)aValue;
- (NSString *)URLEncodedKey;
- (NSString *)URLEncodedValue;
- (NSString *)URLEncodedKeyValuePair;

@end
