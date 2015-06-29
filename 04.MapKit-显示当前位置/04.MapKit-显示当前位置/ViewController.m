//
//  ViewController.m
//  04.MapKit-显示当前位置
//
//  Created by Vincent_Guo on 15-1-25.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 设置地图样式
//    self.mapView.mapType = MKMapTypeSatellite;
    
    
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView.delegate = self;
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"经度%f 纬度%f",userLocation.coordinate.longitude,userLocation.coordinate.latitude);
   
    userLocation.title = @"广州";
    userLocation.subtitle = @"花城广场";
    
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.004013, 0.002529));
    
    mapView.region = region;
}


- (IBAction)backCurrentLocation:(id)sender {
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{

    NSLog(@" 经度跨度 %f 纬度跨度%f",mapView.region.span.longitudeDelta,mapView.region.span.latitudeDelta);
}

@end
