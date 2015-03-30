//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by baizihan on 3/28/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NSString * const ManagedObjectContextSaveDidFailNotification;

#define FATAL_CORE_DATA_ERROR(__error__)\
NSLog(@"*** Fatal error in %s:%d\n%@\n%@",\
__FILE__,__LINE__,error,[error userInfo]);\
[[NSNotificationCenter defaultCenter]postNotificationName:\
ManagedObjectContextSaveDidFailNotification object:error];

@interface LocationDetailsViewController : UITableViewController<UITextViewDelegate>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,strong)CLPlacemark *placemark;
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;

@end
