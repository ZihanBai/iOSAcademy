//
//  FirstViewController.m
//  MyLocations
//
//  Created by baizihan on 3/23/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "CurrentLocationViewController.h"

@interface CurrentLocationViewController ()

@end

@implementation CurrentLocationViewController{
    CLLocationManager *_locationManager;
    CLLocation *_location;
    NSError *_lastLocationError;
    BOOL _updatingLocation;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        _locationManager = [[CLLocationManager alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getLocation:(id)sender {
    [self startLocationManager];
    [self updateLabels];
}

-(void)updateLabels{
    if (_location != nil) {
        self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f",_location.coordinate.latitude];
        self.longtitudeLabel.text = [NSString stringWithFormat:@"%.8f",_location.coordinate.longitude];
        self.tagButton.hidden = NO;
        self.messageLabel.text = @"";
    }else{
        self.latitudeLabel.text = @"";
        self.longtitudeLabel.text = @"";
        self.addressLabel.text = @"";
        self.tagButton.hidden = YES;
        
        NSString *statusMessage;
        if (_lastLocationError != nil) {
            if ([_lastLocationError.domain isEqualToString:kCLErrorDomain] && _lastLocationError.code == kCLErrorDenied) {
                statusMessage = @"对不起，用户禁用了定位功能";
            }else{
                statusMessage = @"对不起，获取位置信息失败";
            }
        }else if(_updatingLocation){
            statusMessage = @"定位中...";
        }else{
            statusMessage = @"请触碰按钮开始定位";
        }
        
        self.messageLabel.text = statusMessage;
        
    }
    
}

-(void)startLocationManager{
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [_locationManager startUpdatingLocation];
        _updatingLocation = YES;
    }
}

-(void)stopLocationManager{
    if (_updatingLocation) {
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        _updatingLocation = NO;
    }
}

#pragma mark -CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败:%@",error);
    if (error.code == kCLErrorLocationUnknown) {
        return;
    }
    [self stopLocationManager];
    _lastLocationError = error;
    [self updateLabels];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"坐标已更新：%@",newLocation);
    _lastLocationError = nil;
    _location = newLocation;
    [self updateLabels];
}


































@end
