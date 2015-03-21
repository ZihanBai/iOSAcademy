//
//  IconPickerTableViewController.h
//  Checklists
//
//  Created by baizihan on 3/21/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerTableViewController;

@protocol IconPickerTableViewControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerTableViewController*)picker didPickIcon:(NSString *)iconName;

@end

@interface IconPickerTableViewController : UITableViewController

@property (nonatomic,weak)id <IconPickerTableViewControllerDelegate>delegate;

@end
