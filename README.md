# CCSpriteWithHue

`CCSpriteWithHue` is a subclass of `CCSprite` from [cocos2d](https://github.com/cocos2d/cocos2d-iphone) that allows to programmatically adjust hue of the sprite.
 
The hue rotation technique allows you to get thousands of colorful variations of your original sprite. Supports animations and transparency.

<p align="center">
  <img src="https://raw.github.com/alex314/blob_files/master/images/CCSpriteWithHueExample.png" alt="Comparison of CCSprite' color and CCSpriteWithHue' hue"/>
</p>
Author of the original image is Stanislav Novarenko (Lord_Lambert)

The basics of the hue rotation algorithm were borrowed from Apple's [GLImageProcessing sample project](https://developer.apple.com/library/ios/samplecode/GLImageProcessing/Introduction/Intro.html)

## Demo

Build and run the __`CCSpriteWithHue-Sample`__ project in Xcode

## Example Usage

``` objective-c
CCSpriteWithHue* sprite = [CCSpriteWithHue spriteWithFile: @"mySprite.png"];
sprite.hue = M_PI_4;
```

The hue property represents the hue rotation angle from __0 to 2 * π__ radians, but you can specify any value (it will remove full revolutions).

## License

`CCSpriteWithHue` is available under the MIT license. See the LICENSE file for more info.
