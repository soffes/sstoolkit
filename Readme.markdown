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
* [SSTextField][] - simply add edge insets
* [SSWebView][] - handy delegate additions and control over shadows and scroll

### Controls

* [SSTextField][] - inset your text
* [SSTextView][] - placeholder!

### View Controllers

* [SSCollectionViewController][] - manage a collection view
* [SSPickerViewController][] - easily create picker view controllers like the Settings app
* [SSViewController][] - custom modal craziness

### Cells

* [SSTableViewCell][] - a fast cell

### Misc

* [SSDrawingMacros][] - random macros for drawing and such
* [SSConcurrentOperation][] - a simple wrapper for concurrent NSOperations
* [SSKeychain][] - makes dealing with the keychain less sucky

### Categories

[Several categories](http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSCategories.h) are included and used throughout SSToolkit.

## Adding SSToolkit to your project

1. Run the following command to add the submodule. Be sure you have are you in the root of your git repository.

        $ git submodule add git://github.com/samsoffes/sstoolkit.git Frameworks/SSToolkit

2. In Finder, navigate to the `Frameworks/SSToolkit` folder and drag the `xcodeproj` file into the `Frameworks` folder in your Xcode project.

3. In Finder, drag `SSToolkit.bundle` located in `Frameworks/SSToolkit/Resources` into the `Resources` folder in your Xcode project.

4. Select the SSToolkit Xcode project from the sidebar in Xcode. In the file browser on the right in Xcode, click the checkbox next to `libSSToolkit.a`. (If you don't see the file browser, hit Command-Shift-E to toggle it on.)

5. Select your target from the sidebar and open Get Info (Command-I).

6. Choose the *General* tab from the top.

7. Under the *Direct Dependencies* area, click the plus button, select *SSToolkit* from the menu, and choose *Add Target*.

8. Choose the build tab from the top of the window. Make sure the configuration dropdown at the top is set to *All Configurations*.

9. Add `Frameworks/SSToolkit` to *Header Search Path* (do not click the *Recursive* checkbox).

10. Add `-all_load -ObjC` to *Other Linker Flags*.

## Usage

To use SSToolkit, simply add the following line to your source file.

    #import <SSToolkit/SSToolkit.h>

You can add this to your prefix to make things easy if you want. You can also import individual files instead of the whole framework (for faster compile times) by doing something like:

    #import <SSToolkit/SSLoadingView.h>

If you are going to use SSToolkit's categories, you will need to import then separately (since some people might not want to use them). You import then like this:

    #import <SSToolkit/SSCategories.h>

## Demo

[SSCatalog][] is included with SSToolkit. There is an iPhone application target and an universal iPad/iPhone application target to demonstrate the various features of SSToolkit.

## Links

* [Known bugs](http://github.com/samsoffes/sstoolkit/issues/labels/Bug)
* [Future features](http://github.com/samsoffes/sstoolkit/issues/labels/Enhancement)

## Thanks

Huge thanks to all of the [contributors](https://github.com/samsoffes/sstoolkit/contributors). Thanks [Jake Marsh](http://github.com/jakemarsh) and [Mike Rundle](http://twitter.com/flyosity) for their snippets of hackery.

[SSViewController]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSViewController.h
[SSPickerViewController]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSPickerViewController.h
[SSHUDView]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSHUDView.h
[SSCollectionView]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSCollectionView.h
[SSGradientView]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSGradientView.h
[SSLabel]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSLabel.h
[SSLineView]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSLineView.h
[SSLoadingView]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSLoadingView.h
[SSPieProgressView]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSPieProgressView.h
[SSTextField]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTextField.h
[SSWebView]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSWebView.h
[SSCollectionViewController]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSCollectionViewController.h
[SSTextField]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTextField.h
[SSTextView]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTextView.h
[SSTableViewCell]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSTableViewCell.h
[SSDrawingMacros]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSDrawingMacros.h
[SSConcurrentOperation]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSConcurrentOperation.h
[SSKeychain]: http://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSKeychain.h
[SSCatalog]: https://github.com/samsoffes/sstoolkit/tree/master/SSCatalog/
