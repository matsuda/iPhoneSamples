//
//  TextLayer1.m
//  TestCocos2d
//
//  Created by matsuda on 2012/10/04.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TextLayer1.h"
#import "TextLayer2.h"

#define TRANSITION_DURATION (1.2f)

@implementation TextLayer1

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];

	// 'layer' is an autorelease object.
	TextLayer1 *layer = [TextLayer1 node];

	// add layer as a child to scene
	[scene addChild: layer];

	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        CGFloat x, y;
        CGSize size = [[CCDirector sharedDirector] winSize];
        x = size.width;
        y = size.height;

        CCSprite *sprite = [CCSprite spriteWithFile:@"layer1.jpg"];
        sprite.position = ccp(x/2, y/2);
        [self addChild:sprite];

        // Menu
        CCMenuItemImage *item = [CCMenuItemImage itemWithNormalImage:@"item_button.png" selectedImage:@"item_button.png" target:self selector:@selector(transitionToScene2:)];
        CCMenu *menu = [CCMenu menuWithItems:item, nil];
        menu.position = CGPointZero;
        item.position = ccp(item.contentSize.width / 2, item.contentSize.height / 2);
        [self addChild:menu z:1];
    }
    return self;
}

- (void)transitionToScene2:(id)sender
{
    NSLog(@"%s", __func__);
    CCScene *s2 = [TextLayer2 scene];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:TRANSITION_DURATION scene:s2] ];
}

@end
