//
//  CZTaxiLocationAnnotation.h
//  09.滴滴打车
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CZTaxi.h"

@interface CZTaxiLocationAnnotation : NSObject<MKAnnotation>
/**
 * 出租车当前经纬度位置
 */
@property (nonatomic) CLLocationCoordinate2D coordinate;

/**
 * 出租车模型
 */
@property(nonatomic,strong)CZTaxi *taxi;

@end
