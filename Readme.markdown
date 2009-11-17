# TWToolkit

TWToolkit makes life easy as an iPhone developer.

## Classes

### Connection

* [TWURLRequest][] - convenient request wrapper
* [TWURLConnection][] - simple remote connections
* [TWURLConnectionQueue][] - connection queueing

### View Controllers

* [TWPickerViewController][] - easily create picker view controllers like the Settings app

### Views

* [TWHUDView][] - simple heads-up display
* [TWLoadingView][] - flexible loading view
* [TWGradientView][] - easily create gradients
* [TWRemoteImageView][] - remote images made easy

### Table View Cells

* [TWSwitchTableViewCell][] - cell with a switch

### Categories

Several categories are included in TWToolkit used throughout TWToolkit.

## Adding TWToolkit to your project

1. Run the following command to add the submodule. Be sure you have been added to the project on GitHub.

        git submodule add git@github.com:tastefulworks/twtoolkit.git Frameworks/TWToolkit

2. In Finder, navigate to the `Frameworks/TWToolkit` folder and drag the `xcodeproj` file into the `Frameworks` folder in your Xcode project.

3. In Finder, drag `TWToolkit.bundle` located in `Frameworks/TWToolkit/Resources` into the `Resources` folder in your Xcode project.

4. Select the TWToolkit Xcode project from the sidebar in Xcode. In the file browser on the right in Xcode, click the checkbox next to `libTWToolkit.a`. (If you don't see the file browser, hit Command-Shift-E to toggle it on.)

5. Select your target from the sidebar and open Get Info (Command-I).

6. Choose the *General* tab from the top.

7. Under the *Direct Dependencies* area, click the plus button, select *TWToolkit* from the menu, and choose *Add Target*.

8. Choose the build tab from the top of the window. Make sure the configuration dropdown at the top is set to *All Configurations*.

9. Add `Frameworks/TWToolkit` to *Header Search Path* (do not click the *Recursive* checkbox). It may help to use search for it in the *Search in Build Settings* field.

10. Add `-all_load -ObjC` to *Other Linker Flags*.

## Usage

To use TWToolkit, simply add the following line to your source file.

    #import <TWToolkit/TWToolkit.h>

You can also import individual files instead of the whole framework (for faster compile times) by doing something like:

    #import <TWToolkit/TWLoadingView.h>

## Known Bugs

* [TWGradientView][]'s `startColor` and `endColor` must be in the same colorspace. The colorspace of the first color is used to draw the gradient. If you did a gradient from white to blue, it would look like a gradient from white to black because the first color, white, is in the gray color space, not the RGB color space. If you did it from blue to white, it would look like blue to black because white in the gray colorspace isn't a valid color in the RGB colorspace (because there are only 2 components in the gray colorspace and 4 in the RGB colorspace). Automatic colorspace conversions are planned for the future.

[TWURLRequest]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWURLRequest.h
[TWURLConnection]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWURLConnection.h
[TWURLConnectionQueue]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWURLConnectionQueue.h
[TWPickerViewController]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWPickerViewController.h
[TWHUDView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWHUDView.h
[TWLoadingView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWLoadingView.h
[TWGradientView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWGradientView.h
[TWRemoteImageView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWRemoteImageView.h
[TWSwitchTableViewCell]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWSwitchTableViewCell.h
