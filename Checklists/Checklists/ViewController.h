//
//  ViewController.h
//  Checklists
//
//  Created by baizihan on 3/10/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"
@interface ViewController : UITableViewController<AddItemViewControllerDelegate>
- (IBAction)addItem:(id)sender;


@end

