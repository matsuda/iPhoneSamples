//
//  TransitionLayer2.m
//  TestCocos2d
//
//  Created by matsuda on 2012/10/04.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "TransitionLayer2.h"
#import "TransitionLayer1.h"

@implementation TransitionLayer2

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
        [self addChild:sprite z:-1];
    }
    return self;
}

- (void)transitionToScene2:(id)sender
{
    NSLog(@"%s", __func__);
    if (![self.transitionName length]) return;
    NSLog(@"transitionName >>>> %@", self.transitionName);

    Class transition = NSClassFromString(self.transitionName);
//    CCScene *s2 = [TransitionLayer1 scene];
//    TransitionLayer1 *layer = [s2.children objectAtIndex:0];
    CCScene *s2 = [CCScene node];
    TransitionLayer1 *layer = [TransitionLayer1 node];
    layer.transitionName = self.transitionName;
    [s2 addChild:layer];

    NSLog(@"scene >>>>>>>>>>>>>>>>> %@", s2);
    [[CCDirector sharedDirector] replaceScene: [transition transitionWithDuration:TRANSITION_DURATION scene:s2] ];
}

@end
