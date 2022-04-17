# SwiftGraphene

A Swift wrapper around graphene-1.x that is largely auto-generated from gobject-introspection.
For up to date (auto-generated) reference documentation, see https://rhx.github.io/SwiftGraphene/

![macOS 12 build](https://github.com/rhx/SwiftGraphene/workflows/macOS%2012/badge.svg)
![Ubuntu 20.04 build](https://github.com/rhx/SwiftGraphene/workflows/Ubuntu%2020.04/badge.svg)
![Ubuntu 18.04 build](https://github.com/rhx/SwiftGraphene/workflows/Ubuntu%2018.04/badge.svg)

## Prerequisites

### Swift 5.6 or higher

To build, download Swift from https://swift.org/download/ -- if you are using macOS, make sure you have the command line tools installed as well).  Test that your compiler works using `swift --version`, which should give you something like

	$ swift --version
	swift-driver version: 1.45.2 Apple Swift version 5.6 (swiftlang-5.6.0.323.62 clang-1316.0.20.8)
    Target: x86_64-apple-darwin20.3.0

on macOS, or on Linux you should get something like:

	$ swift --version
	Swift version 5.6.0 (swift-5.6.0-RELEASE)
	Target: x86_64-unknown-linux-gnu

### GLib 2.56 and Graphene 1.10 or higher

These Swift wrappers have been tested with glib-2.56, 2.58, 2.60, 2.62, 2.64, 2.66, 2.68, 2.70, and 2.72, as well as Graphene 1.10.  They should work with higher versions, but YMMV.  Also make sure you have `gobject-introspection` and its `.gir` files installed.

#### Linux

##### Ubuntu

On Ubuntu 20.04 you can use the Graphene that comes with the distribution.  Just install with the `apt` package manager:

	sudo apt update
	sudo apt install libgraphene-dev gir1.2-graphene-0.0 gobject-introspection libgirepository1.0-dev libxml2-dev

##### Fedora

On Fedora 29, you can use the gtk that comes with the distribution.  Just install with the `dnf` package manager:

	sudo dnf install graphene-devel glib2-devel gobject-introspection-devel libxml2-devel

#### macOS

On macOS, you can install Graphene using HomeBrew (for setup instructions, see http://brew.sh).  Once you have a running HomeBrew installation, you can use it to install a native version of Graphene:

	brew update
	brew install graphene glib glib-networking gobject-introspection pkg-config

## Usage

Normally, you don't build this package directly (but for testing you can - see 'Building' below). Instead you need to embed SwiftGraphene into your own project using the [Swift Package Manager](https://swift.org/package-manager/).  After installing the prerequisites (see 'Prerequisites' below), add `SwiftGraphene` as a dependency to your `Package.swift` file, e.g.:

```Swift
// swift-tools-version:5.6

import PackageDescription

let package = Package(name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/rhx/gir2swift.git", branch: "main"),
        .package(url: "https://github.com/rhx/SwiftGraphene.git",  branch: "main"),
    ],
    targets: [
        .target(name: "MyPackage",
                dependencies: [
                    .product(name: "Graphene", package: "SwiftGraphene")
                ]
        )
    ]
)
```

## Building

Normally, you don't build this package directly, but you embed it into your own project (see 'Usage' above).  However, you can build and test this module separately to ensure that everything works.  Make sure you have all the prerequisites installed (see above).  After that, you can simply clone this repository and build the command line executable (be patient, this will download all the required dependencies and take a while to compile) using

	git clone https://github.com/rhx/SwiftGraphene.git
	cd SwiftGraphene
    swift build
    swift test

### Xcode

On macOS, you can build the project using Xcode instead.  To do this, you need to create an Xcode project first, then open the project in the Xcode IDE:

	./xcodegen.sh
	open Graphene.xcodeproj

After that, use the (usual) Build and Test buttons to build/test this package.

## Documentation

You can find reference documentation inside the [docs](https://rhx.github.io/SwiftGLib/) folder.
This was generated using the [jazzy](https://github.com/realm/jazzy) tool.
If you want to generate your own documentation, matching your local installation,
you can use the `generate-documentation.sh` script in the repository.
Make sure you have [sourcekitten](https://github.com/jpsim/SourceKitten) and [jazzy](https://github.com/realm/jazzy) installed, e.g. on macOS:

	brew install sourcekitten
	sudo gem install jazzy
	./generate-documentation.sh


## Troubleshooting

Here are some common errors you might encounter and how to fix them.

### Old Swift toolchain or Xcode

If you get an error such as

	$ ./build.sh 
	error: unable to invoke subcommand: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift-package (No such file or directory)
	
this probably means that your Swift toolchain is too old.  Make sure the latest toolchain is the one that is found when you run the Swift compiler (see above).

  If you get an older version, make sure that the right version of the swift compiler is found first in your `PATH`.  On macOS, use xcode-select to select and install the latest version, e.g.:

	sudo xcode-select -s /Applications/Xcode.app
	xcode-select --install
