//
//  ChecklistItem.h
//  Checklists
//
//  Created by baizihan on 3/13/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)BOOL checked;
-(void)toggleChecked;
@end
