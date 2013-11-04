# CCSpriteWithHue

`CCSpriteWithHue` is a subclass of `CCSprite` from [cocos2d](https://github.com/cocos2d/cocos2d-iphone) which allows to programmatically change the hue of the sprite in runtime using a fragment shader.

In games it is often necessary for multiple characters to differ only in color, for example, to play in different teams.

You can certainly duplicate all animations in a different color palette and attach them to the project, but it drastically increases the size of the application and restricts user to choose from a limited number of color sets.

There is an alternative approach with `color` property of `CCSprite`, but it tints the sprite in a single color and it loses its colorfulness.
 
With `CCSpriteWithHue` you can use a hue rotation technique to get a thousand of colorful variations of your original sprite, and __it works perfectly with animations and transparency__.
<p align="center">
  <img src="https://raw.github.com/alex314/blob_files/master/images/CCSpriteWithHueExample.png" alt="Comparison of CCSprite' color and CCSpriteWithHue' hue"/>
</p>
An author of an original image is [Lord_Lambert](https://www.fl.ru/users/Lord_Lambert/viewproj.php?prjid=4180816)

The basics for hue rotation algorithm were taken from Apple's [GLImageProcessing sample project](https://developer.apple.com/library/ios/samplecode/GLImageProcessing/Introduction/Intro.html)

I optimised the algo so that it does not affect the performance even if the hue value is changing rapidly.

## Demo

Build and run the __`CCSpriteWithHue-Sample`__ project in Xcode

## Example Usage

``` objective-c
CCSpriteWithHue * sprite = [CCSpriteWithHue spriteWithFile:@"mySprite.png"];
sprite.hue = M_PI_4;
```

The hue property represents the hue rotation angle from __0 to 2 * π__ radians, but you can specify any value, it will remove a complete revolutions.

---

## Contact

Alexey Naumov

- http://github.com/alex314
- a.naumov91@gmail.com

## License

`CCSpriteWithHue` is available under the MIT license. See the LICENSE file for more info.