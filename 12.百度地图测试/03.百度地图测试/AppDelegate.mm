//
//  AppDelegate.m
//  03.百度地图测试
//
//  Created by Vincent_Guo on 15-1-29.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "AppDelegate.h"
#import "BMapKit.h"

@interface AppDelegate ()<BMKGeneralDelegate>
@property(nonatomic,strong)BMKMapManager *manager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.manager = [[BMKMapManager alloc] init];
    
    BOOL result = [self.manager start:@"cDgoHADMTtzOxOYdn4kpTGDN" generalDelegate:self];
    if(!result){
        NSLog(@"启动百度引擎失败");
    };
    return YES;
}


//- (void)applicationWillResignActive:(UIApplication *)application {
//    [BMKMapView willBackGround];
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    
//    [BMKMapView didForeGround];
//}


-(void)onGetNetworkState:(int)iError{
    NSLog(@"网络状态%d",iError);
}

-(void)onGetPermissionState:(int)iError{
    NSLog(@"授权 %d",iError);
    if (iError == 0) {
        NSLog(@"授权通过");
    }
}

@end
