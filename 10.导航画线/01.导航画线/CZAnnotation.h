//
//  CZAnnotation.h
//  02.导航画线
//
//  Created by apple on 14-11-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CZAnnotation : NSObject<MKAnnotation>


@property (nonatomic) CLLocationCoordinate2D coordinate;


// Title and subtitle for use by selection UI.
@property (nonatomic,copy) NSString *title;
@end
