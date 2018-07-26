# about-canada
A Swift 4 POC using collection view in three diffrent way.
Checkout latest alpha release [v1.0-alpha](https://github.com/kmp52k/about-canada/releases/tag/v1.0-alpha)

## Contents
- [Summery](#summery)
- [Screens](#screens)
- [Requirements](#requirements)
- [Installation](#installation)

## Summery:

1. Landing screen: Fix height dynamic columns collection view with pull to refresh and error handling.
2. Carousal view: Full screen sliding carousal view with actual image size limited by screen size.
3. Pintrest layout: Custom Pintrest layout to render collection view cards dynamic sized with dynamic number of columns according to Image size and description text length.

## Screens:

|                   iPad                   |      iPhone      |
|---------------------------|--------------|
|![simulator screen shot - ipad air - 2018-07-26 at 19 37 58](https://user-images.githubusercontent.com/28494537/43267796-8e3e867a-910c-11e8-96db-0406303d4c09.png)|![simulator screen shot - iphone 6 - 2018-07-26 at 19 39 14](https://user-images.githubusercontent.com/28494537/43267852-adcdf3ea-910c-11e8-8189-c93cc3399e75.png)|
|![simulator screen shot - ipad air - 2018-07-26 at 19 38 48](https://user-images.githubusercontent.com/28494537/43267928-eb54f998-910c-11e8-97a9-eeefc9ce8fff.png)|![simulator screen shot - iphone 6 - 2018-07-26 at 19 39 33](https://user-images.githubusercontent.com/28494537/43267993-187004e0-910d-11e8-909b-7379918a2242.png)|
|![simulator screen shot - ipad air - 2018-07-26 at 19 51 28](https://user-images.githubusercontent.com/28494537/43268118-681f031a-910d-11e8-8234-2d8f6964e26f.png)|![simulator screen shot - ipad air - 2018-07-26 at 19 50 59](https://user-images.githubusercontent.com/28494537/43268154-842a0d0c-910d-11e8-8fda-7a268148c722.png)|


## Columns distribution for Landing screen & Pintrest layout:

### iPhone 
- Portrait mode: 1 column
- Lanscape mode: 2 columns

### iPad 
- Portrait mode: 2 columns
- Lanscape mode: 3 columns

## Requirements

- iOS 9.0+
- Swift 4.0+

## Installation

Checkout Podfile for more info.

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build Reusable 1.0.0+.


Then, run the following command:

```bash
$ pod install
```

Run the app on your Simulator or Device.
