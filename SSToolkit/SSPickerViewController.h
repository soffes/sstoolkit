//
//  SSPickerViewController.h
//  SSToolkit
//
//  Created by Sam Soffes on 10/9/08.
//  Copyright 2008-2011 Sam Soffes. All rights reserved.
//

/**
 This is an abstract class for displaying a `UITableView` with a list of items for the user to choose similar to
 Settings.app.
 
 A subclass should override the `- (void)loadObjects` and `- (NSString *)cellTextForObject:(id)anObject` methods to
 customize this class.
 
 A subclass can optionally override `- (void)cellImageForKey:(id)key` to show an image in the cell.
 */
@interface SSPickerViewController : UITableViewController

@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) id selectedKey;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

- (void)loadKeys;
- (NSString *)cellTextForKey:(id)key;
- (UIImage *)cellImageForKey:(id)key;

@end
