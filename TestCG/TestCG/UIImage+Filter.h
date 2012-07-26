//
//  UIImage+Filter.h
//  TestCG
//
//  Created by matsuda on 12/07/25.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Filter)

- (UIImage*)gradationImage:(CGRect)rect;
- (UIImage*)averageFilter:(NSInteger)pixel toRect:(CGRect)rect;

@end
