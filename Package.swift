// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Graphene",
    products: [
        .library(
            name: "Graphene",
            targets: ["Graphene"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rhx/gir2swift.git",    branch: "development"),
        .package(url: "https://github.com/rhx/SwiftGObject.git", branch: "development")
    ],
    targets: [
        .systemLibrary(
            name: "CGraphene",
            pkgConfig: "graphene-gobject",
            providers: [
                .brew(["graphene", "glib", "glib-networking", "gobject-introspection"]),
                .apt(["libgraphene-dev", "libglib2.0-dev", "glib-networking", "gobject-introspection", "libgirepository1.0-dev"])
            ]),
        .target(
            name: "Graphene",
            dependencies: [
                "CGraphene",
                .product(name: "gir2swift",  package: "gir2swift"),
                .product(name: "GLibObject", package: "SwiftGObject"),
            ],
            swiftSettings: [
                .unsafeFlags(["-suppress-warnings"], .when(configuration: .release)),
                .unsafeFlags(["-suppress-warnings", "-Xfrontend", "-serialize-debugging-options"], .when(configuration: .debug)),
            ],
            plugins: [
                .plugin(name: "gir2swift-plugin", package: "gir2swift")
            ]
        ),
        .testTarget(
            name: "GrapheneTests",
            dependencies: ["Graphene"]),
    ]
)