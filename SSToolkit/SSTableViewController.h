//
//  SSTableViewController.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/14/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSViewController.h"

/**
 @brief The SSTableViewController class creates a controller object that manages a table view.
 
 This class is a SSViewController subclass that is a drop-in replacement for UITableViewController.
 */
@interface SSTableViewController : SSViewController <UITableViewDataSource, UITableViewDelegate> {

@private
	
	UITableView *_tableView;
	BOOL _clearsSelectionOnViewWillAppear;
}

/**
 @brief Returns the table view managed by the controller object.
 */
@property (nonatomic, retain) UITableView *tableView;

/**
 @brief A Boolean value indicating if the controller clears the selection when the table appears.
 
 The default value of this property is YES. When YES, the table view controller clears the table's
 current selection when it receives a viewWillAppear: message. Setting this property to <code>NO</code>
 preserves the selection.
 */
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

/**
 @brief Initializes a table-view controller to manage a table view of a given style.
 
 @param style A constant that specifies the style of table view that the controller object
 is to manage (UITableViewStylePlain or UITableViewStyleGrouped).
 
 @return An initialized UITableViewController object or nil if the object couldn’t be created.
 
 If you use the standard init method to initialize a UITableViewController object, a table view
 in the plain style is created.
 */
- (id)initWithStyle:(UITableViewStyle)style;

@end
