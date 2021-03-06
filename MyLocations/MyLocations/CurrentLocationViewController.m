//
//  FirstViewController.m
//  MyLocations
//
//  Created by baizihan on 3/23/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "CurrentLocationViewController.h"
#import "LocationDetailsViewController.h"

@interface CurrentLocationViewController ()

@end

@implementation CurrentLocationViewController{
    CLLocationManager *_locationManager;
    CLLocation *_location;
    CLGeocoder *_geoCoder;
    CLPlacemark *_placemark;
    NSError *_lastLocationError;
    NSError *_lastGeocodingError;
    BOOL _updatingLocation;
    BOOL _performingGeocoding;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        _locationManager = [[CLLocationManager alloc]init];
        _geoCoder = [[CLGeocoder alloc]init];
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
    [self configureGetButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getLocation:(id)sender {
    if (_updatingLocation) {
        [self stopLocationManager];
    }else{
        _location = nil;
        _lastLocationError = nil;
        _placemark = nil;
        _lastGeocodingError = nil;
        [self startLocationManager];
    }
    [self updateLabels];
    [self configureGetButton];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"TagLocation"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        LocationDetailsViewController *controller = (LocationDetailsViewController*)navigationController.topViewController;
        
        controller.coordinate = _location.coordinate;
        controller.placemark = _placemark;
        controller.managedObjectContext = self.managedObjectContext;
    }
}

-(NSString *)stringFromPlacemark:(CLPlacemark *)placemark{
    return [NSString stringWithFormat:@"%@ %@\n%@ %@ %@",placemark.subThoroughfare,placemark.thoroughfare,placemark.locality,placemark.administrativeArea,placemark.postalCode];
}

-(void)updateLabels{
    if (_location != nil) {
        self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f",_location.coordinate.latitude];
        self.longtitudeLabel.text = [NSString stringWithFormat:@"%.8f",_location.coordinate.longitude];
        self.tagButton.hidden = NO;
        self.messageLabel.text = @"";
        
        if (_placemark != nil) {
            self.addressLabel.text = [self stringFromPlacemark:_placemark];
        }else if (_performingGeocoding){
            self.addressLabel.text = @"出错啦~";
        }else{
            self.addressLabel.text = @"没找到";
        }
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

-(void)didTimeOut:(id)obj{
    NSLog(@" oops,超时了");
    if (_location == nil) {
        [self stopLocationManager];
        _lastLocationError = [NSError errorWithDomain:@"MyLocationsErrorDomain" code:1 userInfo:nil];
        [self updateLabels];
        [self configureGetButton];
    }
}

-(void)startLocationManager{
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [_locationManager startUpdatingLocation];
        _updatingLocation = YES;
        
        [self performSelector:@selector(didTimeOut:) withObject:nil afterDelay:60];
        
    }
}

-(void)stopLocationManager{
    if (_updatingLocation) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didTimeOut:) object:nil];
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        _updatingLocation = NO;
    }
}

-(void)configureGetButton{
    if (_updatingLocation) {
        [self.getButton setTitle:@"停停停" forState:UIControlStateNormal];
    }else{
        [self.getButton setTitle:@"获取当前所在位置" forState:UIControlStateNormal];
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
    [self configureGetButton];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"坐标已更新：%@",newLocation);
    if ([newLocation.timestamp timeIntervalSinceNow] < -5.0) {
        return;
    }
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    CLLocationDistance distance = MAXFLOAT;
    if (_location != nil) {
        distance = [newLocation distanceFromLocation:_location];
    }
    
    if (_location == nil || _location.horizontalAccuracy > newLocation.horizontalAccuracy) {
        _lastLocationError = nil;
        _location = newLocation;
        [self updateLabels];
        if (newLocation.horizontalAccuracy <= _locationManager.desiredAccuracy) {
            NSLog(@"定位完成");
            [self stopLocationManager];
            [self configureGetButton];
        }
    }
    
    if (distance > 0) {
        _performingGeocoding = NO;
    
    
    if (!_performingGeocoding) {
        NSLog(@"Going to Geocoding");
        _performingGeocoding = YES;
        [_geoCoder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemarks,NSError *error){
            NSLog(@"Found placemarks:%@,error:%@",placemarks,error);
            _lastGeocodingError = error;
            if (error == nil && [placemarks count] > 0) {
                _placemark = [placemarks lastObject];
            }else{
                _placemark = nil;
            }
            _performingGeocoding = NO;
            [self updateLabels];
        }];
    }
    }else if (distance < 1.0){
        NSTimeInterval timeInterval = [newLocation.timestamp timeIntervalSinceDate:_location.timestamp];
        if (timeInterval > 10) {
            NSLog(@" 强制完成");
            [self stopLocationManager];
            [self updateLabels];
            [self configureGetButton];
        }
    }
}


































@end
