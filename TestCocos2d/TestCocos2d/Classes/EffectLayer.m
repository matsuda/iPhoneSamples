//
//  EffectLayer.m
//  TestCocos2d
//
//  Created by matsuda on 2012/10/05.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EffectLayer.h"


@implementation EffectLayer

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    EffectLayer *layer = [EffectLayer node];
    [scene addChild:layer];
    return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isTouchEnabled = YES;

        CGFloat x, y;
        CGSize size = [[CCDirector sharedDirector] winSize];
        x = size.width;
        y = size.height;

        CCSprite *sprite = [CCSprite spriteWithFile:@"layer2.jpg"];
        sprite.position = ccp(x/2, y/2);
        [self addChild:sprite];

        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:bg z:-1];
    }
    return self;
}

- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
    CGPoint l = [self convertTouchToNodeSpace:touch];
    NSLog(@"location >>>> %@", NSStringFromCGPoint(l));

    CGPoint location = [touch locationInView:[touch view]];
    CGPoint position = [[CCDirector sharedDirector] convertToGL:location];
    NSLog(@"position >>>> %@", NSStringFromCGPoint(position));

    CCParticleSystem *ps = [CCParticleFireworks node];
    ps.sourcePosition = position;
    ps.autoRemoveOnFinish = YES;
    [self addChild:ps];
}

@end
