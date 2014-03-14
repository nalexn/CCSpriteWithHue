//
//  CCSpriteWithHue.h
//  CCSpriteWithHue-Sample
//
//  Created by Alexey Naumov on 02/11/13.
//  Copyright (c) 2013 Alexey Naumov. All rights reserved.


//  Disclaimer: the basics for hue rotation algorithm were taken from Apple's GLImageProcessing sample project:
//  https://developer.apple.com/library/ios/samplecode/GLImageProcessing/Introduction/Intro.html

#import "CCSprite.h"

@interface CCSpriteWithHue : CCSprite
{
    GLint _hueLocation;
    GLint _alphaLocation;
}

// Hue rotation angle in radians. Default is 0.0, i.e. natural hue
@property (nonatomic, unsafe_unretained) CGFloat hue;

@end

@interface CCSpriteWithHueWithRedThreshold : CCSpriteWithHue {
    GLint _redThresholdLocation;
}

// Value from 0.0 to 1.0. Hue rotation is applied only for pixels with red component lower than this value
@property (nonatomic, unsafe_unretained) CGFloat redThreshold;

@end
