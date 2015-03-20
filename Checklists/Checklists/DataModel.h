//
//  DataModel.h
//  Checklists
//
//  Created by baizihan on 3/20/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property (nonatomic,strong)NSMutableArray *lists;

-(void)saveChecklists;
-(NSInteger)indexOfSelectedChecklist;
-(void)setIndexOfSelectedChecklist:(NSInteger)index;
@end
