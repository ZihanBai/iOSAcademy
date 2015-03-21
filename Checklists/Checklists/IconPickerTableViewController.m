//
//  IconPickerTableViewController.m
//  Checklists
//
//  Created by baizihan on 3/21/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "IconPickerTableViewController.h"

@interface IconPickerTableViewController ()

@end

@implementation IconPickerTableViewController{
    NSArray *_icons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _icons = @[
               @"No Icon",
               @"Appointments",
               @"Birthdays",
               @"Chores",
               @"Drinks",
               @"Folder",
               @"Groceries",
               @"Inbox",
               @"Photos",
               @"Trips"
               ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_icons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell" forIndexPath:indexPath];
    NSString *icon = _icons[indexPath.row];
    cell.textLabel.text = icon;
    cell.imageView.image = [UIImage imageNamed:icon];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *iconName = _icons[indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}


@end
