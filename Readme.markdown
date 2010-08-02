# TWToolkit

TWToolkit makes life easier. It is made up of various view controllers, views, and categories that we use at [Tasteful Works][] for our apps. Feel free to fork the repo and help us make it better.

## Classes

### View Controllers

* [TWViewController][] - custom modal craziness
* [TWPickerViewController][] - easily create picker view controllers like the Settings app
* [TWMessagesViewController][] - simple message UI like the built-in SMS app

### Views

* [TWGradientView][] - easily create gradients with optional borders and insets
* [TWHUDView][] - simple heads-up display
* [TWLabel][] - ever wanted to align your text to the top or the bottom
* [TWLineView][] - easily create lines with an inset
* [TWLoadingView][] - flexible loading view
* [TWPieProgressView][] - pie chart style progress bar similar to the one in Xcode's status bar
* [TWTextField][] - simply add edge insets
* [TWWebView][] - handy delegate additions and control over shadows and scroll (still betay)

### Categories

[Several categories](http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWCategories.h) are included and used throughout TWToolkit.

## Adding TWToolkit to your project

1. Run the following command to add the submodule. Be sure you have been added to the project on GitHub.

        git submodule add git://github.com/tastefulworks/twtoolkit.git Frameworks/TWToolkit

2. In Finder, navigate to the `Frameworks/TWToolkit` folder and drag the `xcodeproj` file into the `Frameworks` folder in your Xcode project.

3. In Finder, drag `TWToolkit.bundle` located in `Frameworks/TWToolkit/Resources` into the `Resources` folder in your Xcode project.

4. Select the TWToolkit Xcode project from the sidebar in Xcode. In the file browser on the right in Xcode, click the checkbox next to `libTWToolkit.a`. (If you don't see the file browser, hit Command-Shift-E to toggle it on.)

5. Select your target from the sidebar and open Get Info (Command-I).

6. Choose the *General* tab from the top.

7. Under the *Direct Dependencies* area, click the plus button, select *TWToolkit* from the menu, and choose *Add Target*.

8. Choose the build tab from the top of the window. Make sure the configuration dropdown at the top is set to *All Configurations*.

9. Add `Frameworks/TWToolkit` to *Header Search Path* (do not click the *Recursive* checkbox).

10. Add `-all_load -ObjC` to *Other Linker Flags*.

## Usage

To use TWToolkit, simply add the following line to your source file.

    #import <TWToolkit/TWToolkit.h>

You can also import individual files instead of the whole framework (for faster compile times) by doing something like:

    #import <TWToolkit/TWLoadingView.h>

## Demo

[TWCatalog][] is include with TWToolkit. This is a sample iPhone application to demonstrate the various features of TWToolkit.

## Links

* [Known bugs](http://github.com/tastefulworks/twtoolkit/issues/labels/Bug)
* [Future features](http://github.com/tastefulworks/twtoolkit/issues/labels/Enhancement)

[Tasteful Works]: http://tastefulworks.com/
[TWViewController]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWViewController.h
[TWPickerViewController]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWPickerViewController.h
[TWMessagesViewController]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWMessagesViewController.h
[TWHUDView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWHUDView.h
[TWGradientView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWGradientView.h
[TWLabel]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWLabel.h
[TWLineView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWLineView.h
[TWLoadingView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWLoadingView.h
[TWPieProgressView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWPieProgressView.h
[TWTextField]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWTextField.h
[TWWebView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWWebView.h
[TWCatalog]: https://github.com/tastefulworks/twtoolkit/tree/master/TWCatalog/
