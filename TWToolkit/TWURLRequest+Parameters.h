//
//  TWURLRequest+Parameters.h
//  TWToolkit
//
//  Created by Sam Soffes on 11/9/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWURLRequest.h"

@interface TWURLRequest (Parameters)

- (NSArray *)parameters;
- (void)setParameters:(NSArray *)parameters;
- (void)appendParameters:(NSArray *)additionalParameters;
- (void)appendParameter:(TWURLRequestParameter *)parameter;

@end
