Create, Push, and Present Any View Controller in 1 LOC using Metaprogramming
======================================

#### A supplementary example for an [article](https://medium.com/@ivangoremykin/create-push-and-present-any-view-controller-in-1-loc-using-metaprogramming-33f673284d92)

![](https://github.com/ivangoremykin/uiviewcontroller-metaprogramming/blob/media/editorial-illustration.png)

# Summary

This is an example project that uses [Sourcery](https://github.com/krzysztofzablocki/Sourcery) to generate functions that let you create, push, and present every view controller in 1 LOC.
Please refer to the [article](https://medium.com/@ivangoremykin/create-push-and-present-any-view-controller-in-1-loc-using-metaprogramming-33f673284d92) for the details.

There are 4 view controllers to illustrate all possible cases:

|  | Has Initialization Parameters | No Initialization Parameters |
| --- | :---: | :---: |
| **Programmatic** | `SpringViewController` | `SummerViewController` |
| **Storyboard Instantiatable** | `AutumnViewController` | `WinterViewController` |

<img src="https://github.com/ivangoremykin/uiviewcontroller-metaprogramming/blob/media/example-app-screenshot.png" alt="drawing" width="400"/>

# Project Structure
We try to keep ≤ 5 folders at each level of a project structure.
```
Source
├── Behavior       // view controllers, controllers, app events, etc.
├── External       // shared Git submodules
├── Generated      // view controller routines, serialization, etc.
├── Routines       // web-services, local storages, data model, etc.
└── UserInterface  // storyboards, views, cells, etc.
Meta
├── Configuration
│   └── Sourcery.yml
└── Templates
    ├── Common
    ├── Tests
    └── UIViewController
Tests
└── Resources
```
- *Sourcery* is embedded into the *Xcode* building process as a *Run Script* phase. It automatically regenerates code on any changes in the template file or in the project source files.
- The *Sourcery* configuration file is project-specific. The templates can be shared between your other projects, so you can enable/disable specific templates on a project basis.
- The `Source` directory contains all code: both hand-written and generated. All generated code is stored in the `Generated` folder. We do keep it under *Git* since we want to build our project even if (for any reason) code can't be generated.
- The `Tests` directory contains all our testing code: both hand-written and generated.

# Requirements

* Xcode 10.3
* Swift 5.0

# Installation

Open **Terminal** and navigate to the directory that contains the `Podfile` using the `cd` command:
```bash
$ cd ~/Path/To/Folder/Containing/Podfile
```

In the `Podfile` directory, type:

```bash
$ pod install
```

# Credits
Icons made by [Smashicons](https://www.flaticon.com/authors/smashicons) and [Freepik](https://www.flaticon.com/authors/freepik) from www.flaticon.com ([CC BY 3.0](http://creativecommons.org/licenses/by/3.0/)).

# License
This example is licensed under the MIT License, see [License.md](https://github.com/ivangoremykin/uiviewcontroller-metaprogramming/blob/master/License.md) for more information.
