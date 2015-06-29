//
//  CZAnnotation.h
//  04.MapKit-自定义大头针模型
//
//  Created by Vincent_Guo on 15-1-26.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CZAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
