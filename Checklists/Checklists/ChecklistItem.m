//
//  ChecklistItem.m
//  Checklists
//
//  Created by baizihan on 3/13/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem
-(void)toggleChecked{
    self.checked = !self.checked;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeInteger:self.itemId forKey:@"ItemId"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeObjectForKey:@"Checked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntegerForKey:@"ItemID"];
    }
    return self;
}

-(id)init{
    if ((self = [super init])) {
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

@end
