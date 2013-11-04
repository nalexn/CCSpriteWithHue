//
//  IntroLayer.m
//  CCSpriteWithHue-Sample
//
//  Created by Alexey Naumov on 02/11/13.
//  Copyright Alexey Naumov 2013. All rights reserved.
//

#import "IntroLayer.h"
#import "CCSpriteWithHue.h"

@implementation IntroLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	IntroLayer *layer = [IntroLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        [self addChild:[CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)]];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        self.sprite = [CCSpriteWithHue spriteWithFile:@"alien.png"];
        _sprite.position = ccp(winSize.width * 0.5, winSize.height * 0.55);
        [self addChild:_sprite];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"grossini-aliases.plist"];
        NSMutableArray * spriteFrames = [NSMutableArray array];
        for (int i = 1; i < 15; ++i)
        {
            NSString * frameName = [NSString stringWithFormat:@"grossini_dance_%02d.png",i];
            [spriteFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName]];
        }
        CCAnimation * animation = [CCAnimation animationWithSpriteFrames:spriteFrames delay:0.1];
        self.animatedSprite = [CCSpriteWithHue spriteWithSpriteFrame:[spriteFrames objectAtIndex:0]];
        [_animatedSprite runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]]];
        _animatedSprite.position = ccp(winSize.width * 0.5, winSize.height * 0.35);
        [self addChild:_animatedSprite];
        
        UIView * mainView = [[CCDirector sharedDirector] view];
        
        UISlider * sliderHue = [[[UISlider alloc] init] autorelease];
        sliderHue.center = ccp(winSize.width * 0.5, winSize.height * 0.8);
        [sliderHue addTarget:self action:@selector(onChangedSliderValue:) forControlEvents:UIControlEventValueChanged];
        [mainView addSubview:sliderHue];
        
        UIButton * buttonAction = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonAction setTitle:@"Action" forState:UIControlStateNormal];
        buttonAction.bounds = CGRectMake(0.0, 0.0, winSize.width * 0.3, winSize.height * 0.05);
        buttonAction.center = ccp(winSize.width * 0.5, winSize.height * 0.9);
        [buttonAction addTarget:self action:@selector(onPressedButton:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:buttonAction];
	}
	return self;
}

#pragma mark - 

- (void) onChangedSliderValue: (UISlider *) slider
{
    CGFloat value = slider.value; // 0 .. 1
    CGFloat hue = value * 2.0 * M_PI; // 0 .. 2 * Pi
    _sprite.hue = hue;
    _animatedSprite.hue = hue;
}

- (void) onPressedButton: (UIButton *) button
{
    [_sprite runAction:[self actionForHue:_sprite.hue]];
    [_animatedSprite runAction:[self actionForHue:_animatedSprite.hue]];
}

- (CCAction *) actionForHue: (CGFloat) hue
{
    return [CCActionTween actionWithDuration:2.0 key:@"hue" from:hue to:(hue + 6.0 * M_PI)];
}

@end
