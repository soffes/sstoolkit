//
//  SSWebViewController.m
//  SSToolKit
//
//  Created by Sam Soffes on 7/28/12.
//  Copyright 2012 Sam Soffes. All rights reserved.
//

#import "SSWebViewController.h"

#import "UIImage+SSToolkitAdditions.h"

@interface SSWebViewController () {
    SSWebView *_webView;
	NSURL *_url;
	UIActivityIndicatorView *_indicator;
	UIBarButtonItem *_backBarButton;
	UIBarButtonItem *_forwardBarButton;
}

- (void)_updateBrowserUI;

- (void)close:(id)sender;
- (void)openSafari:(id)sender;
- (void)openActionSheet:(id)sender;
- (void)copyURL:(id)sender;
- (void)emailURL:(id)sender;

@end

@implementation SSWebViewController

#pragma mark - NSObject

- (id)init {
	if ((self = [super init])) {
		_useToolbar = YES;
	}
	return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 22.0f, 22.0f)];
	_indicator.hidesWhenStopped = YES;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_indicator];
	
	_webView = [[SSWebView alloc] initWithFrame:self.view.bounds];
	_webView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	_webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_webView.delegate = self;
	_webView.scalesPageToFit = YES;
	[_webView loadURL:_url];
	[self.view addSubview:_webView];
	
	_backBarButton = [[UIBarButtonItem alloc]
                      initWithImage:[UIImage imageNamed:@"back-button.png" bundleName:kSSToolkitBundleName]
                      landscapeImagePhone:[UIImage imageNamed:@"back-button-mini.png" bundleName:kSSToolkitBundleName]
                      style:UIBarButtonItemStylePlain
                      target:_webView
                      action:@selector(goBack)];
	_forwardBarButton = [[UIBarButtonItem alloc]
                         initWithImage:[UIImage imageNamed:@"forward-button.png" bundleName:kSSToolkitBundleName]
                         landscapeImagePhone:[UIImage imageNamed:@"forward-button-mini.png" bundleName:kSSToolkitBundleName]
                         style:UIBarButtonItemStylePlain
                         target:_webView
                         action:@selector(goForward)];
	
	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 10.0;

	self.toolbarItems = @[
        fixedSpace,
        _backBarButton,
        flexibleSpace,
        _forwardBarButton,
        flexibleSpace,
        [[UIBarButtonItem alloc]
         initWithImage:[UIImage imageNamed:@"reload-button.png" bundleName:kSSToolkitBundleName]
         landscapeImagePhone:[UIImage imageNamed:@"reload-button-mini.png" bundleName:kSSToolkitBundleName]
         style:UIBarButtonItemStylePlain
         target:_webView
         action:@selector(reload)],
        flexibleSpace,
        [[UIBarButtonItem alloc]
         initWithImage:[UIImage imageNamed:@"safari-button.png" bundleName:kSSToolkitBundleName]
         landscapeImagePhone:[UIImage imageNamed:@"safari-button-mini.png" bundleName:kSSToolkitBundleName]
         style:UIBarButtonItemStylePlain
         target:self
         action:@selector(openSafari:)],
        flexibleSpace,
        [[UIBarButtonItem alloc]
         initWithImage:[UIImage imageNamed:@"action-button.png" bundleName:kSSToolkitBundleName]
         landscapeImagePhone:[UIImage imageNamed:@"action-button-mini.png" bundleName:kSSToolkitBundleName]
         style:UIBarButtonItemStylePlain
         target:self
         action:@selector(openActionSheet:)],
        fixedSpace
     ];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(close:)];
	}
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	if (_useToolbar && ![_url isFileURL]) {
		[self.navigationController setToolbarHidden:NO animated:animated];
	}
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

	if (_useToolbar) {
		[self.navigationController setToolbarHidden:YES animated:animated];
	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		return YES;
	}
	
	return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}


#pragma mark - URL Loading

- (void)loadURL:(NSURL *)url {
	_url = url;
    [_webView stopLoading];
    [_webView loadURL:url];
}


- (NSURL *)currentURL {
	NSURL *url = _webView.lastRequest.mainDocumentURL;
	if (!url) {
		url = _url;
	}
	return url;
}


#pragma mark - Actions

- (void)close:(id)sender {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_5_0
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
	[self.navigationController dismissModalViewControllerAnimated:YES];
#endif
}


- (void)openSafari:(id)sender {
	[[UIApplication sharedApplication] openURL:self.currentURL];
}


- (void)openActionSheet:(id)sender {
	UIActionSheet *actionSheet = nil;
	
	if ([MFMailComposeViewController canSendMail] == NO) {
		actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Copy URL", nil];
	} else {
		actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Copy URL", @"Email URL", nil];
	}
	
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[actionSheet showInView:self.navigationController.view];
}


- (void)copyURL:(id)sender {
	[[UIPasteboard generalPasteboard] setURL:self.currentURL];
}


- (void)emailURL:(id)sender {
	if ([MFMailComposeViewController canSendMail] == NO) {
		return;
	}
	
	MFMailComposeViewController *viewController = [[MFMailComposeViewController alloc] init];
	viewController.subject = self.title;
	viewController.mailComposeDelegate = self;
	[viewController setMessageBody:_webView.lastRequest.mainDocumentURL.absoluteString isHTML:NO];
	
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_5_0
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        [self presentViewController:viewController animated:YES completion:nil];
        return;
    }
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
    [self presentModalViewController:viewController animated:YES];
#endif
}


#pragma mark - Private

- (void)_updateBrowserUI {
	_backBarButton.enabled = [_webView canGoBack];
	_forwardBarButton.enabled = [_webView canGoForward];

	UIBarButtonItem *reloadButton = nil;
	
	if ([_webView isLoadingPage]) {
		[_indicator startAnimating];
		reloadButton = [[UIBarButtonItem alloc]
                        initWithImage:[UIImage imageNamed:@"stop-button.png" bundleName:kSSToolkitBundleName]
                        landscapeImagePhone:[UIImage imageNamed:@"stop-button-mini.png" bundleName:kSSToolkitBundleName]
                        style:UIBarButtonItemStylePlain
                        target:_webView
                        action:@selector(stopLoading)];
	} else {
		[_indicator stopAnimating];
		reloadButton = [[UIBarButtonItem alloc]
                        initWithImage:[UIImage imageNamed:@"reload-button.png" bundleName:kSSToolkitBundleName]
                        landscapeImagePhone:[UIImage imageNamed:@"reload-button-mini.png" bundleName:kSSToolkitBundleName]
                        style:UIBarButtonItemStylePlain
                        target:_webView
                        action:@selector(reload)];
	}
	
	NSMutableArray *items = [self.toolbarItems mutableCopy];
	[items replaceObjectAtIndex:5 withObject:reloadButton];
	self.toolbarItems = items;
}


#pragma mark - SSWebViewDelegate

- (void)webViewDidStartLoadingPage:(SSWebView *)aWebView {
	NSURL *url = _webView.lastRequest.mainDocumentURL;
	self.title = url.absoluteString;
	[self _updateBrowserUI];

	if (_useToolbar) {
		[self.navigationController setToolbarHidden:[url isFileURL] animated:YES];
	}
}


- (void)webViewDidLoadDOM:(SSWebView *)aWebView {
	NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	if (title && title.length > 0) {
		self.title = title;
	}
}


- (void)webViewDidFinishLoadingPage:(SSWebView *)aWebView {
	[self _updateBrowserUI];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		[self copyURL:actionSheet];
	} else if (buttonIndex == 1 && [MFMailComposeViewController canSendMail]) {
		[self emailURL:actionSheet];
	}
}


#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_5_0
    if ([self respondsToSelector:@selector(dismissViewControllerAnimated:completion:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
	[self.navigationController dismissModalViewControllerAnimated:YES];
#endif
}

@end
