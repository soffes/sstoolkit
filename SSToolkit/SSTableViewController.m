//
//  SSTableViewController.m
//  SSToolkit
//
//  Created by Sam Soffes on 10/14/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSTableViewController.h"
#import "SSDrawingMacros.h"

@implementation SSTableViewController

@synthesize tableView = _tableView;
@synthesize clearsSelectionOnViewWillAppear = _clearsSelectionOnViewWillAppear;

#pragma mark NSObject

- (id)init {
	self = [self initWithStyle:UITableViewStylePlain];
	return self;
}


- (void)dealloc {
	_tableView.dataSource = nil;
	_tableView.delegate = nil;
	[_tableView release];
	[super dealloc];
}


#pragma mark UIViewController

- (void)loadView {
	[super loadView];
	
	// Unlike UITableViewController, add the UITableView to the view controller's
	// view instead of replacing it for more flexibility
	
	[self.view addSubview:self.tableView];
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// TODO: Only reload if data is empty
	[self.tableView reloadData];

	if (_clearsSelectionOnViewWillAppear) {
		[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
	}
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.tableView flashScrollIndicators];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	[self.tableView setEditing:editing animated:animated];
}


#pragma mark SSViewController

- (void)layoutViewsWithOrientation:(UIInterfaceOrientation)orientation {
	[super layoutViewsWithOrientation:orientation];
	self.tableView.frame = CGRectSetZeroOrigin(self.view.frame);
}


#pragma mark Initializer

- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super init]) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
		_tableView.dataSource = self;
		_tableView.delegate = self;
		_clearsSelectionOnViewWillAppear = YES;
	}
	return self;
}


#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

@end
