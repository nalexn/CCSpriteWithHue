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

@property (nonatomic, unsafe_unretained) CGFloat hue; // Hue rotation angle in radians. Default is 0.0, i.e. natural hue

@end
