//
//  IntroLayer.h
//  CCSpriteWithHue-Sample
//
//  Created by Alexey Naumov on 02/11/13.
//  Copyright Alexey Naumov 2013. All rights reserved.
//

#import "cocos2d.h"

@class CCSpriteWithHue;

@interface IntroLayer : CCLayer

@property (nonatomic, strong) CCSpriteWithHue * sprite;
@property (nonatomic, strong) CCSpriteWithHue * animatedSprite;

+(CCScene *) scene;

@end
