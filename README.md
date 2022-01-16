# ICSwift

## Description

A quality-of-life package of Swift property extensions to make our lives a bit easier.

If you have any suggestions be comfortable in _forking_ this repository and
create a **Pull Request**. I would be happy to have you as a contributer.

Some extensions used within this package can be found in the etcetera repository, from Jared Sinclair.

## Requirements

iOS 11.0+ 
Xcode 12.0+
Swift 4.0+

## Notes to contributors

Please use the implicit `return` whenever possible.

If you want to contribute to any present extension, or add more extensions, please don't forget to write a **Unit Test** for it, whenever is possible. It is important to test each custom extension to assert they work as expected and increases its reliability. 
(still ongoing)

## Instalation

### Swift Package Manager

Swift Package Manager is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate ICSwift into your Xcode project using Swift Package Manager, add it to the dependencies value of your Package.swift:

```
dependencies: [
    .package(url: "https://github.com/ivancantarino/ICSwift.git")
]
```

### Manual

If you want to integrate `ICSwift` into your project, just copy the Package files into your project.
