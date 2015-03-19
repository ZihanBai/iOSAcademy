//
//  AllListsViewController.m
//  Checklists
//
//  Created by baizihan on 3/18/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"
#import "ChecklistItem.h"
@interface AllListsViewController ()

@end

@implementation AllListsViewController{
    NSMutableArray *_lists;
}

#pragma mark 数据加载和保存
-(NSString *)documentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSLog(@"documentsDirectory: %@",documentsDirectory);
    return documentsDirectory;
}

-(NSString *)dataFilePath{
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklist.plist"];
}

-(void)saveChecklists{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:_lists forKey:@"Checklists"];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

-(void)loadChecklists{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        _lists = [unarchiver decodeObjectForKey:@"Checklists"];
        [unarchiver finishDecoding];
    }else{
        _lists = [[NSMutableArray alloc]initWithCapacity:20];
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        [self loadChecklists];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_lists count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Checklist *checklist = _lists[indexPath.row];
    cell.textLabel.text = checklist.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Checklist *checklist = _lists[indexPath.row];
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
        ChecklistViewController *controller = segue.destinationViewController;
        controller.checklist = sender;
    }else if ([segue.identifier isEqualToString:@"AddChecklist"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.checklistToEdit = nil;
    }
}

-(void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAdding:(Checklist *)checklist{
    NSInteger newRowIndex = [_lists count];
    [_lists addObject:checklist];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEditing:(Checklist *)checklist{
    NSInteger index = [_lists indexOfObject:checklist];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = checklist.name;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_lists removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    Checklist *checklist = _lists[indexPath.row];
    controller.checklistToEdit = checklist;
    [self presentViewController:navigationController animated:YES completion:nil];
    
}



@end
