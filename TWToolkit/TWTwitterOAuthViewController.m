//
//  TWTwitterOAuthViewController.m
//  TWToolkit
//
//  Created by Sam Soffes on 11/3/09.
//  Copyright 2009 Tasteful Works, Inc. All rights reserved.
//

#import "TWTwitterOAuthViewController.h"
#import "TWTwitterOAuthInternalViewController.h"

@implementation TWTwitterOAuthViewController

@synthesize delegate;
@dynamic consumer;

#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Make sure we have a consumer
	if (self.consumer == nil) {
		if ([delegate respondsToSelector:@selector(twitterOAuthViewController:didFailWithError:)]) {
			NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"TWTwitterOAuthViewController requires a valid OAConsumer to authorize.", NSLocalizedDescriptionKey, nil];
			NSError *error = [NSError errorWithDomain:@"com.tasetfulworks.twtwitteroauthviewcontroller" code:-1 userInfo:userInfo];
			[delegate twitterOAuthViewController:self didFailWithError:error];
		}
		return;
	}
}

#pragma mark -
#pragma mark Initalizer
#pragma mark -

- (id)initWithDelegate:(id<TWTwitterOAuthViewControllerDelegate>)aDelegate consumer:(OAConsumer *)aConsumer {
	TWTwitterOAuthInternalViewController *internalViewController = [[TWTwitterOAuthInternalViewController alloc] initWithNibName:nil bundle:nil];
	if (self = [super initWithRootViewController:internalViewController]) {
		self.delegate = aDelegate;
		self.consumer = aConsumer;
	}
	[internalViewController release];
	return self;
}

#pragma mark -
#pragma mark Actions
#pragma mark -

- (void)cancel:(id)sender {
	if ([delegate respondsToSelector:@selector(twitterOAuthViewControllerDidCancel:)]) {
		[delegate twitterOAuthViewControllerDidCancel:self];
	}
}


#pragma mark -
#pragma mark Getters
#pragma mark -

- (OAConsumer *)consumer {
	return [(TWTwitterOAuthInternalViewController *)self.topViewController consumer];
}


#pragma mark -
#pragma mark Setters
#pragma mark -

- (void)setConsumer:(OAConsumer *)aConsumer {
	return [(TWTwitterOAuthInternalViewController *)self.topViewController setConsumer:aConsumer];
}

@end
