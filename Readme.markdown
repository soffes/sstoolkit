# SSToolkit

SSToolkit makes life easier. It is made up of various view controllers, views, and categories that I use in all of my apps. Feel free to fork the repo and make it better.

If you're using this in your project, I'd love to hear about it! [Send me an email](mailto:sam@samsoff.es) and let me know which pieces you're using and such.

## Classes

### Views

* [SSCollectionView][] - simple collection view modeled after UITableView and NSCollectionView
* [SSGradientView][] - easily create gradients with optional borders and insets
* [SSHUDView][] - simple heads-up display
* [SSLabel][] - ever wanted to align your text to the top or the bottom
* [SSLineView][] - easily create lines with an inset
* [SSLoadingView][] - flexible loading view
* [SSPieProgressView][] - pie chart style progress bar similar to the one in Xcode's status bar
* [SSWebView][] - handy delegate additions and control over shadows and scroll

## Cells

* [SSBadgeTableViewCell][] - badge accessory view for table cells, similar to Mail.app unread counts

### Controls

* [SSAddressBarTextField][] - textfield to show loading progress and control a web view
* [SSTextField][] - inset your text
* [SSTextView][] - placeholder!
* [SSSegmentedControl][] - segmented control clone so make customizing the appearance easier
* [SSSwitch][] - switch clone so make customizing the appearance easier

### View Controllers

* [SSCollectionViewController][] - manage a collection view
* [SSPickerViewController][] - easily create picker view controllers like the Settings.app
* [SSRatingPickerViewController][] - simple view controller for rating stuff like App Store.app
* [SSViewController][] - custom modal craziness

### Misc

* [SSDrawingMacros][] - random macros for drawing and such
* [SSConcurrentOperation][] - a simple wrapper for concurrent NSOperations

### Categories

[Several categories](http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSCategories.h) are included and used throughout SSToolkit.

## Adding SSToolkit to your project

For installation instructions, see [the getting started guide on the SSToolkit website](http://sstoolk.it/#getting-started).

## Usage

For usage instructions, see [the usage guide on the SSToolkit website](http://sstoolk.it/#usage).

## Demo

[SSCatalog][] is included with SSToolkit. There is an iPhone application target and an universal iPad/iPhone application target to demonstrate the various features of SSToolkit.

## Links

* [Homepage](http://sstoolk.it)
* [Source code](http://github.com/samsoffes/sstoolkit)
* [Documentation](http://sstoolk.it/documentation/)
* [Known bugs](http://github.com/samsoffes/sstoolkit/issues/labels/Bug)
* [Future features](http://github.com/samsoffes/sstoolkit/issues/labels/Feature)

## Thanks

Huge thanks to [our contributors](http://github.com/samsoffes/sstoolkit/contributors), [Jake Marsh](http://deallocatedobjects.com), and [Mike Rundle](http://flyosity.com).

[SSViewController]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSViewController.h
[SSPickerViewController]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSPickerViewController.h
[SSHUDView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSHUDView.h
[SSCollectionView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSCollectionView.h
[SSGradientView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSGradientView.h
[SSLabel]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSLabel.h
[SSLineView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSLineView.h
[SSLoadingView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSLoadingView.h
[SSPieProgressView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSPieProgressView.h
[SSTextField]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTextField.h
[SSWebView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSWebView.h
[SSCollectionViewController]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSCollectionViewController.h
[SSTextField]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTextField.h
[SSTextView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTextView.h
[SSTableViewCell]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTableViewCell.h
[SSDrawingMacros]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSDrawingMacros.h
[SSConcurrentOperation]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSConcurrentOperation.h
[SSKeychain]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSKeychain.h
[SSCatalog]: https://github.com/samsoffes/sstoolkit/tree/master/SSCatalog/
[SSBadgeTableViewCell]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSBadgeView.h
[SSRatingPickerViewController]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSRatingPickerViewController.h
[SSAddressBarTextField]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSAddressBarTextField.h
[SSSegmentedControl]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSSegmentedControl.h
[SSSwitch]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSSwitch.h
