//
//  ViewController.h
//  Checklists
//
//  Created by baizihan on 3/10/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"
@class Checklist;

@interface ChecklistViewController : UITableViewController<ItemDetailViewControllerDelegate>

@property (nonatomic,strong)Checklist *checklist;


@end

