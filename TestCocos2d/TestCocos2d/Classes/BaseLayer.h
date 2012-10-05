//
//  BaseLayer.h
//  TestCocos2d
//
//  Created by matsuda on 2012/10/05.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCTransitionHelper.h"

#define TRANSITION_DURATION (0.7f)

@interface BaseLayer : CCLayer {
}

@property (nonatomic, copy) NSString *transitionName;

+ (CCScene *)scene;

@end
