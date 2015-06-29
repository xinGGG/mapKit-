//
//  CZTaxiLocationAnnotation.m
//  09.滴滴打车
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "CZTaxiLocationAnnotation.h"

@implementation CZTaxiLocationAnnotation

-(void)setTaxi:(CZTaxi *)taxi{
    _taxi = taxi;
    
    //设置标注的经纬度
    CLLocationDegrees latitude = [taxi.latitude doubleValue];
    CLLocationDegrees longitude = [taxi.longitude doubleValue];
    CLLocationCoordinate2D coordnate = CLLocationCoordinate2DMake(latitude, longitude);
    _coordinate = coordnate;
}

@end
