# AYRealmer

[![CI Status](https://img.shields.io/travis/antonyereshchenko@gmail.com/AYRealmer.svg?style=flat)](https://travis-ci.org/antonyereshchenko@gmail.com/AYRealmer)
[![Version](https://img.shields.io/cocoapods/v/AYRealmer.svg?style=flat)](https://cocoapods.org/pods/AYRealmer)
[![License](https://img.shields.io/cocoapods/l/AYRealmer.svg?style=flat)](https://cocoapods.org/pods/AYRealmer)
[![Platform](https://img.shields.io/cocoapods/p/AYRealmer.svg?style=flat)](https://cocoapods.org/pods/AYRealmer)

<p align="center">
  <img width="64%" height="64%" src="https://github.com/bananaRanger/AYRealmer/blob/master/Resources/logo.png?raw=true">
</p>

## About

AYRealmer library - is a wrapper that allows you to interact only with models instead of realm-entities.

## Installation

AYRealmer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
inhibit_all_warnings!

target 'YOUR_TARGET_NAME' do
  use_frameworks!
	pod 'AYRealmer'
end
```

## Usage

```swift

// 'AYRConfiguration' - enum that confirm to protocol 'AYDataBaseConfiguration' (configuration).
// 'User' - struct that confirm to protocol 'AYRealmConvertibleModel' (model).

// 1. Create 'AYRealmer' object with configuration and file location
var realmer = AYRealmer(with: AYRConfiguration.user, in: .documents)

// 2. Prepare 'User' object for saving
var user = User()
user.email = "tester@gmail.com"
user.fullName = "Tester User"

// 3. Store 'User' object
realmer.add(model: user)

// 4. Fetch & print 'User' objects
let users: [User] = realmer.objects()
print(users)

// 5. Remove 'User' object
realmer.remove(model: user)

```

## Author

[📧](mailto:anton.yereshchenko@gmail.com?subject=[GitHub]%20Source%20AYRealmer) Anton Yereshchenko

## License

AYRealmer is available under the MIT license. See the LICENSE file for more info.
