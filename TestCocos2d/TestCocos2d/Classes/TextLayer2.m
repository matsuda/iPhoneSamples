//
//  TextLayer2.m
//  TestCocos2d
//
//  Created by matsuda on 2012/10/04.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TextLayer2.h"


@implementation TextLayer2

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];

	// 'layer' is an autorelease object.
	TextLayer2 *layer = [TextLayer2 node];

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

        CCSprite *sprite = [CCSprite spriteWithFile:@"layer2.jpg"];
        sprite.position = ccp(x/2, y/2);
        [self addChild:sprite];
    }
    return self;
}

@end
