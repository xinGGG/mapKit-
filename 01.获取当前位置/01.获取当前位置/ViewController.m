//
//  ViewController.m
//  01.获取当前位置
//
//  Created by Vincent_Guo on 15-1-25.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

/**
 * 定位管理者
 */
@property(nonatomic,strong)CLLocationManager *manager;
@end

@implementation ViewController

-(CLLocationManager *)manager{
    if (!_manager) {
        // 1.创建定位管理者
        _manager = [[CLLocationManager alloc] init];
        
        // 2.设置代理
        _manager.delegate = self;
        
        // iOS8无法定位，要做如下设置
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
            // 1.请求在后台使用定位服务的权限
            [_manager requestWhenInUseAuthorization];
            
            // 2.在Info.plist添加NSLocationWhenInUseUsageDescription ＝ YES
            NSLog(@"%s",__func__);
            
        }
        
        //每1000米定位一次
        _manager.distanceFilter = 1000;
        
        //定位的精确度，也就是误差,越精确，越耗电
        _manager.desiredAccuracy = 1;
    }
    
    return _manager;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //模拟器的定位，要自己设置，如果是真机，直接能获取到当前位置
    // 3.开始定位
    [self.manager startUpdatingLocation];
}



#pragma mark  定位管理者代理
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"%s %@",__func__,locations);
    //定位成功后，会一直调用此方法，一般定位成功后，就停止定位
    //[manager stopUpdatingLocation];
    
    //定位信息
    for (CLLocation *location in locations) {
        //经纬度
        CLLocationCoordinate2D coordinate = location.coordinate;
        NSLog(@"经度: %f",coordinate.longitude);
        NSLog(@"纬度: %f",coordinate.latitude);
        NSLog(@"海拔: %f",location.altitude);
        NSLog(@"速度: %f",location.speed);
        
    }
}

@end
