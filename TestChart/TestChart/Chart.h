//
//  Chart.h
//  TestChart
//
//  Created by Kosuke Matsuda on 2012/11/02.
//  Copyright (c) 2012年 matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    NSInteger x;
    NSInteger y;
} ChartCoordinate;

@protocol ChartDataSource;
@protocol ChartDelegate;

@interface Chart : UIView
@property (weak, nonatomic) id<ChartDataSource> dataSource;
@property (weak, nonatomic) id<ChartDelegate> delegate;
@end

@protocol ChartDataSource <NSObject>
- (NSInteger)numberOfXAxisInChart:(Chart *)chart;
- (NSInteger)numberOfYAxisInChart:(Chart *)chart;
- (NSString *)chart:(Chart *)chart cellAtCoordinate:(ChartCoordinate)coordinate;
@end

@protocol ChartDelegate <NSObject>
@end
