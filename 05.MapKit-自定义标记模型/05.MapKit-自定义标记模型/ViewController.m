//
//  ViewController.m
//  04.MapKit-显示当前位置
//
//  Created by Vincent_Guo on 15-1-25.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CZAnnotation.h"

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *manager;
@end

@implementation ViewController

-(CLLocationManager *)manager{
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ios设置 定位授权
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [self.manager requestWhenInUseAuthorization];
    }

    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView.delegate = self;
    
    // 添加自己的标记模型到地图上
    // 1.定义标记模型
    CZAnnotation *annotation = [[CZAnnotation alloc] init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(23.116440, 113.325380);
    // 2.设置标记模型的经纬度
    annotation.coordinate = coordinate;
    // 3.设置标题 子标题
    annotation.title = @"广州图书馆";
    annotation.subtitle = @"开馆时间:9:00-21:00";
    
    // 4.添加到地图上
    [self.mapView addAnnotation:annotation];
    
    
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"经度%f 纬度%f",userLocation.coordinate.longitude,userLocation.coordinate.latitude);
    
    userLocation.title = @"广州";
    userLocation.subtitle = @"花城广场";
    
//    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.004013, 0.002529));
//    
//    mapView.region = region;
}


@end
