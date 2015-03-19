//
//  ListDetailViewController.m
//  Checklists
//
//  Created by baizihan on 3/18/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.checklistToEdit == nil) {
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
    }
    self.tableView.rowHeight = 44;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel:(id)sender{
    [self.delegate listDetailViewControllerDidCancel:self];
}

-(IBAction)done:(id)sender{
    if (self.checklistToEdit == nil) {
        Checklist *checklist = [[Checklist alloc]init];
        checklist.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishAdding:checklist];
    }else{
        self.checklistToEdit.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishEditing:self.checklistToEdit];
    }
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
