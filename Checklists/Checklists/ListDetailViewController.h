//
//  ListDetailViewController.h
//  Checklists
//
//  Created by baizihan on 3/18/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerTableViewController.h"

@class ListDetailViewController;
@class Checklist;

@protocol ListDetailViewControllerDelegate <NSObject>

-(void)listDetailViewControllerDidCancel:(ListDetailViewController*)controller;
-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAdding:(Checklist *)checklist;
-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEditing:(Checklist *)checklist;

@end

@interface ListDetailViewController : UITableViewController<UITextFieldDelegate,IconPickerTableViewControllerDelegate>

@property(nonatomic,weak)IBOutlet UITextField *textField;
@property(nonatomic,weak)IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic,weak)id<ListDetailViewControllerDelegate>delegate;
@property (nonatomic,strong)Checklist *checklistToEdit;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end
