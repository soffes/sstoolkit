# TWToolkit

TWToolkit is a minimalist iPhone framework that simplifies common tasks in iPhone development.

## Classes

### Connection

* [TWConnection][] - simple remote connections

### View Controllers

* [TWPickerViewController][] - easily create picker view controllers like the Settings app

### Views

* [TWHUDView][] - simple heads-up display
* [TWLoadingView][] - flexible loading view
* [TWGradientView][] - easily create gradients

### Table View Cells

* [TWSwitchTableViewCell][] - cell with a switch

### Categories

Several categories are included in TWToolkit used throughout TWToolkit.

[TWConnection]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWConnection.h
[TWPickerViewController]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWPickerViewController.h
[TWHUDView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWHUDView.h
[TWLoadingView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWLoadingView.h
[TWGradientView]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWGradientView.h
[TWSwitchTableViewCell]: http://github.com/tastefulworks/twtoolkit/blob/master/TWToolkit/TWSwitchTableViewCell.h

## Known Bugs

* [TWGradientView][]'s `startColor` and `endColor` must be in the same colorspace. The colorspace of the first color is used to draw the gradient. If you did a gradient from white to blue, it would look like a gradient from white to black because the first color, white, is in the gray color space, not the RGB color space. If you did it from blue to white, it would look like blue to black because white in the gray colorspace isn't a valid color in the RGB colorspace (because there are only 2 components in the gray colorspace and 4 in the RGB colorspace). Automatic colorspace conversions are planned for the future.
