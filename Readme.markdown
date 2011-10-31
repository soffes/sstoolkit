# SSToolkit

SSToolkit makes life easier. It is made up of various view controllers, views, and categories that I use in all of my apps. Feel free to fork the repo and make it better.

If you're using this in your project, I'd love to hear about it! [Send me an email](mailto:sam@samsoff.es) and let me know which pieces you're using and such.

## Documentation

Install the documentation into Xcode with the following steps:

1. Open Xcode Preferences
2. Choose Downloads
3. Choose the Documentation tab
4. Click the plus button in the bottom right and enter the following URL:
    
        http://docs.sstoolk.it/com.samsoffes.sstoolkit.atom

5. Click Install next the new row reading "SSKeychain Documentation". (If you don't see it and didn't get an error, try restarting Xcode.)

Be sure you have the docset selected in the organizer to see results for SSToolkit.

You can also **read the [SSToolkit Documentation](http://sstoolk.it/documentation) online.**

## Classes

### Views

* [SSAnimatedImageView][] - easily create timed or keyframed animations
* [SSBadgeView][] - badge accessory view for table cells, similar to Mail.app unread counts
* [SSBorderedView][] - draw boxes with top and bottom borders with optional insets
* [SSCollectionView][] - simple collection view modeled after UITableView and NSCollectionView
* [SSGradientView][] - easily create gradients with optional borders and insets
* [SSHUDView][] - simple heads-up display
* [SSLabel][] - vertically align and inset your text
* [SSLineView][] - easily create solid, dotted, or dashed lines with an inset
* [SSLoadingView][] - flexible loading view
* [SSPieProgressView][] - pie chart style progress bar similar to the one in Xcode's status bar
* [SSWebView][] - handy delegate additions and control over shadows and scroll

### Controls

* [SSAddressBarTextField][] - textfield to show loading progress and control a web view
* [SSTextField][] - inset your text
* [SSTextView][] - placeholders like `UITextField`
* [SSSegmentedControl][] - segmented control clone so make customizing the appearance easier
* [SSSwitch][] - switch clone so make customizing the appearance easier

### View Controllers

* [SSCollectionViewController][] - manage a collection view
* [SSPickerViewController][] - easily create picker view controllers like the Settings.app
* [SSRatingPickerViewController][] - simple view controller for rating stuff like App Store.app

### Misc

* [SSDrawingUtilities][] - random macros for drawing and such
* [SSConcurrentOperation][] - a simple wrapper for concurrent NSOperations

### Categories

[Several categories](http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSCategories.h) are included and used throughout SSToolkit.

## Adding SSToolkit to your project

For installation instructions, see [the getting started guide on the SSToolkit website](http://sstoolk.it/#getting-started).

## Usage

For usage instructions, see [the usage guide on the SSToolkit website](http://sstoolk.it/#usage).

## Demo

[SSCatalog](https://github.com/samsoffes/sscatalog) is a sample project that demonstrates several features of SSToolkit. It is an universal iPad/iPhone application.

## Links

* [Homepage](http://sstoolk.it)
* [Source code](https://github.com/samsoffes/sstoolkit)
* [Documentation](http://sstoolk.it/documentation/)
* [Known bugs](https://github.com/samsoffes/sstoolkit/issues/labels/Bug)
* [Future features](https://github.com/samsoffes/sstoolkit/issues/labels/Feature)

## Thanks

Huge thanks to [our contributors](http://github.com/samsoffes/sstoolkit/contributors), [Jake Marsh](http://deallocatedobjects.com), and [Mike Rundle](http://flyosity.com).

[SSAnimatedImageView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSAnimatedImageView.h
[SSBadgeView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSBadgeView.h
[SSBorderedView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSBorderedView.h
[SSCollectionView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSCollectionView.h
[SSGradientView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSGradientView.h
[SSHUDView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSHUDView.h
[SSLabel]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSLabel.h
[SSLineView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSLineView.h
[SSLoadingView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSLoadingView.h
[SSPieProgressView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSPieProgressView.h
[SSWebView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSWebView.h
[SSAddressBarTextField]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSAddressBarTextField.h
[SSTextField]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTextField.h
[SSTextView]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTextView.h
[SSSegmentedControl]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSSegmentedControl.h
[SSSwitch]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSSwitch.h
[SSCollectionViewController]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSCollectionViewController.h
[SSPickerViewController]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSPickerViewController.h
[SSRatingPickerViewController]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSRatingPickerViewController.h
[SSDrawingUtilities]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSDrawingUtilities.h
[SSConcurrentOperation]: https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSConcurrentOperation.h
