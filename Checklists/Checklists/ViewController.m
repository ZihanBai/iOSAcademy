//
//  ViewController.m
//  Checklists
//
//  Created by baizihan on 3/10/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSString *_row0text;
    NSString *_row1text;
    NSString *_row2text;
    NSString *_row3text;
    NSString *_row4text;
    BOOL _row0checked;
    BOOL _row1checked;
    BOOL _row2checked;
    BOOL _row3checked;
    BOOL _row4checked;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _row0text = @"你有如下待办事项：";
    _row1text = @"吃大餐";
    _row2text = @"洗澡";
    _row3text = @"上班";
    _row4text = @"逛动物园";
    _row4checked = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(void)configureCheckmarkForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    BOOL isChecked = NO;
    if (indexPath.row == 0) {
        isChecked = _row0checked;
    }else if (indexPath.row == 1){
        isChecked = _row1checked;
    }else if (indexPath.row == 2){
        isChecked = _row2checked;
    }else if (indexPath.row == 3){
        isChecked = _row3checked;
    }else if (indexPath.row == 4){
        isChecked = _row4checked;
    }
    if (isChecked) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    if (indexPath.row % 5 == 0) {
        label.text = _row0text;
    }else if (indexPath.row % 5 == 1)
    {
        label.text = _row1text;
    }else if (indexPath.row % 5 == 2){
        label.text = _row2text;
    }else if (indexPath.row % 5 == 3){
        label.text = _row3text;
    }else if (indexPath.row % 5 == 4){
        label.text = _row4text;
    }
    [self configureCheckmarkForCell:cell atIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL isChecked = NO;
    if (indexPath.row == 0) {
        isChecked = _row0checked;
        _row0checked = !_row0checked;
    }else if (indexPath.row == 1){
        isChecked = _row1checked;
        _row1checked = !_row1checked;
    }else if (indexPath.row == 2){
        isChecked = _row2checked;
        _row2checked = !_row2checked;
    }else if (indexPath.row == 3){
        isChecked = _row3checked;
        _row3checked = !_row3checked;
    }else if (indexPath.row == 4){
        isChecked = _row4checked;
        _row4checked = !_row4checked;
    }
    [self configureCheckmarkForCell:cell atIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
