//
//  ItemDetailViewController.h
//  Checklists
//
//  Created by baizihan on 3/15/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>

-(void)ItemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
-(void)ItemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;
-(void)ItemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;

@end

@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak,nonatomic) id<ItemDetailViewControllerDelegate> delegate;
@property (strong,nonatomic) ChecklistItem *itemToEdit;
@end
