//
//  BaseLayer.m
//  TestCocos2d
//
//  Created by matsuda on 2012/10/05.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseLayer.h"


@implementation BaseLayer

+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];

	// 'layer' is an autorelease object.
	id layer = [self node];

	// add layer as a child to scene
	[scene addChild: layer];

	// return the scene
	return scene;
}

- (void)dealloc
{
    [_transitionName release], _transitionName = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isTouchEnabled = YES;
    }
    return self;
}

- (void)transitionToScene2:(id)sender
{
}

#pragma mark - touch

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
    [self transitionToScene2:nil];
}

@end
