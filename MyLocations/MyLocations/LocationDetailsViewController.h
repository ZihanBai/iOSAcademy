//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by baizihan on 3/28/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationDetailsViewController : UITableViewController<UITextViewDelegate>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,strong)CLPlacemark *placemark;
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;

@end
