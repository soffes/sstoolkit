# SSToolkit Documentation

Simple tools I use for generating [SSToolkit][] documentation.

## Setup

You will also need [Doxygen](http://doxygen.org). You can install this via [Homebrew](http://github.com/mxcl/homebrew) with the following command:

    $ brew install doxygen

## Building

Just run:

    $ rake

The docs will be in the `Output` folder. You can launch the in your browser by running:

    $ rake open

## Xcode Integration

Currently building a docset isn't supported. Since I reformat them to be all pretty, it breaks all of the metadata that Xcode needs for the docset. I plan on rewriting Doxyclean (used to reformat the ugly Doxygen docs) in Ruby. After that is complete, I should be able to add support for a docset.

[SSToolkit]: http://sstoolk.it
