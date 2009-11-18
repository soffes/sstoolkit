//
//  TWURLRequest+Parameters.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequest.h"

@class TWURLRequestParameter;

@interface TWURLRequest (Parameters)

+ (NSArray *)parametersFromString:(NSString *)encodedParameters;

- (NSArray *)parameters;
- (void)setParameters:(NSArray *)parameters;
- (void)setParametersFromString:(NSString *)parametersString;
- (void)appendParameters:(NSArray *)additionalParameters;
- (void)appendParameter:(TWURLRequestParameter *)parameter;
- (void)appendParametersFromString:(NSString *)parametersString;

@end
