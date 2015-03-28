//
//  LocationDetailsViewController.m
//  MyLocations
//
//  Created by baizihan on 3/28/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "LocationDetailsViewController.h"

@interface LocationDetailsViewController ()

@property(nonatomic,weak) IBOutlet UITextView *descriptionTextView;
@property(nonatomic,weak) IBOutlet UILabel *categoryLabel;
@property(nonatomic,weak) IBOutlet UILabel *latitudeLabel;
@property(nonatomic,weak) IBOutlet UILabel *longitudeLabel;
@property(nonatomic,weak) IBOutlet UILabel *addressLabel;
@property(nonatomic,weak) IBOutlet UILabel *dateLabel;

@end

@implementation LocationDetailsViewController

-(void)closeScreen{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)done:(id)sender{
    [self closeScreen];
}

-(IBAction)cancel:(id)sender{
    [self closeScreen];
}

@end
