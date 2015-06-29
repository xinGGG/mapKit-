//
//  ViewController.m
//  02.系统地图导航
//
//  Created by Vincent_Guo on 15-1-29.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *manager;
@end

@implementation ViewController

//-(CLLocationManager *)manager{
//    if (!_manager) {
//        _manager = [[CLLocationManager alloc] init];
//        _manager.delegate = self;
//    }
//    
//    return _manager;
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"%@",locations);
    [self.manager stopUpdatingLocation];
}
-(void)viewDidLoad{
    [super viewDidLoad];
  
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //起点
    MKMapItem *fromItem = [MKMapItem mapItemForCurrentLocation];
    NSLog(@"===%@",fromItem);
    


    //终点
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:@"北京" completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        
        MKPlacemark *toPlacemark = [[MKPlacemark alloc] initWithPlacemark:placemarks[0]];

        MKMapItem *toItem = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
        NSLog(@"===%@",toItem);

        NSDictionary *options = @{
                                  MKLaunchOptionsMapTypeKey://标准地图
                                      @(MKMapTypeStandard),
                                  MKLaunchOptionsDirectionsModeKey://行车路线
                                  MKLaunchOptionsDirectionsModeDriving
                                  };
        
        //打开系统导航
        [MKMapItem openMapsWithItems:@[fromItem,toItem] launchOptions:options];
    }];
    
    
}

@end
