# TWToolkit

TWToolkit makes life easy as an iPhone developer.

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

    #import "TWToolkit/TWToolkit.h"

You can also import individual files instead of the whole framework (for faster compile times) by doing something like `#import TWToolkit/TWLoadingView.h`.

