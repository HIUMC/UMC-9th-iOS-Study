import ProjectDescription

let project = Project(
    name: "MegaBox",
    targets: [
        .target(
            name: "MegaBox",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.MegaBox",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["MegaBox/Sources/**"],
            resources: ["MegaBox/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "MegaBoxTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.MegaBoxTests",
            infoPlist: .default,
            sources: ["MegaBox/Tests/**"],
            resources: [],
            dependencies: [.target(name: "MegaBox")]
        ),
    ]
)
