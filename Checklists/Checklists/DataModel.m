//
//  DataModel.m
//  Checklists
//
//  Created by baizihan on 3/20/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "DataModel.h"
#import "Checklist.h"
@implementation DataModel
-(NSString *)documentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

-(NSString *)dataFilePath{
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklists{
    NSLog(@"saveChecklists");
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"Checklsits"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

-(void)loadChecklists{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
        [unarchiver finishDecoding];
    }else{
        self.lists = [[NSMutableArray alloc]initWithCapacity:20];
    }
}

-(NSInteger)indexOfSelectedChecklist{
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"ChecklistIndex"];
}

-(void)setIndexOfSelectedChecklist:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"ChecklistIndex"];
}

-(void)registerDefaults{
    NSDictionary *dictionary = @{@"ChecklistIndex":@-1};
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary];
}

-(id)init{
    if ((self = [super init])) {
        //[self loadChecklists];
        self.lists = [[NSMutableArray alloc]initWithCapacity:20];
        Checklist *list = [[Checklist alloc]init];
        list.name = @"test";
        [self.lists addObject:list];
        [self registerDefaults];
    }
    return self;
}


@end
