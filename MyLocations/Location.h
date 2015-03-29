//
//  Location.h
//  MyLocations
//
//  Created by baizihan on 3/29/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>


@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * longtitude;
@property (nonatomic, retain) NSString * locationsDescription;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) CLPlacemark * placemark;

@end
