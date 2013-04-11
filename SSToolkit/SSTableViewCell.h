//
//  SSTableViewCell.h
//  SSToolkit
//
//  Created by Eliezer Talón on 11/04/13.
//  Copyright (c) 2013 Sam Soffes. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Reusable UITableViewCell subclass that simplifies cell production

 This is a factory class that encapsulates all the boilerplate code needed to create a reusable UITableViewCell. This is how we would use it:

 1. Create a subclass of SSTableViewCell
 2. Override -initWithCellIdentifier:
 3. Call +cellForTableView: from a table view controller to get a reusable cell

     - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       SSTableViewCell *cell = [SSTableViewCell cellForTableView:tableView];
       cell.textLabel.text = [self.quotes objectAtIndex:indexPath.row];
       return cell;
     }

 This class is based on a recipe from [iOS Recipes](http://pragprog.com/book/cdirec/ios-recipes)'s book
 */
@interface SSTableViewCell : UITableViewCell

#pragma mark - Cell factory
/// @name Cell factory

/**
 Factory method to create and initialize cells

 @param tableView Table that requests a cell
 @return A SSTableViewCell object
 */
+ (instancetype)cellForTableView:(UITableView *)tableView;

/**
 Builds a unique cell identifier to use in subclasses of SSTableViewCell

 The default implementation does not use static values. If performance becomes an issue override this method in your subclasses.

 @return A unique cell identifier based on the SSTableViewCell subclass name
 */
+ (NSString *)cellIdentifier;

/**
 Initializes and configures the cell and its default layout

 This is the designated initializer that must be overriden in subclasses, optionally adding custom properties and customizing the appearance.

 @param cellID Identifier of the cell
 @return A newly allocated SSTableViewCell object
 */
- (instancetype)initWithCellIdentifier:(NSString *)cellID;

@end
