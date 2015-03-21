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

@implementation ListDetailViewController{
    NSString *_iconName;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        _iconName = @"Folder";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.checklistToEdit == nil) {
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
        _iconName = self.checklistToEdit.iconName;
    }
    self.iconImageView.image = [UIImage imageNamed:_iconName];
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

- (IBAction)cancel:(id)sender {
    [self.delegate listDetailViewControllerDidCancel:self];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return indexPath;
    }else{
        return nil;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}
- (IBAction)done:(id)sender {
    NSLog(@"done");
    if (self.checklistToEdit == nil) {
        Checklist *checklist = [[Checklist alloc]init];
        checklist.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishAdding:checklist];
    }else{
        self.checklistToEdit.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishEditing:self.checklistToEdit];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"PickIcon"]) {
        IconPickerTableViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

-(void)iconPicker:(IconPickerTableViewController *)picker didPickIcon:(NSString *)iconName{
    _iconName = iconName;
    self.iconImageView.image = [UIImage imageNamed:_iconName];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)done{
    if (self.checklistToEdit == nil) {
        Checklist *checklist = [[Checklist alloc]init];
        checklist.name = self.textField.text;
        checklist.iconName = _iconName;
        [self.delegate listDetailViewController:self didFinishAdding:checklist];
    }else{
        self.checklistToEdit.name = self.textField.text;
        self.checklistToEdit.iconName = _iconName;
        [self.delegate listDetailViewController:self didFinishAdding:self.checklistToEdit];
    }
}


















@end
