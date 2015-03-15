//
//  AddItemViewController.m
//  Checklists
//
//  Created by baizihan on 3/15/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "AddItemViewController.h"
#import "ChecklistItem.h"
@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender {
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.delegate addItemViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
//    NSLog(@"当前输入的内容是%@",self.textField.text);
    ChecklistItem *item = [[ChecklistItem alloc]init];
    item.text = self.textField.text;
    item.checked = NO;
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.delegate addItemViewController:self didFinishAddingItem:item];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

@end
