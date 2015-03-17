//
//  ChecklistItem.m
//  Checklists
//
//  Created by baizihan on 3/13/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem
-(void)toggleChecked{
    self.checked = !self.checked;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeObjectForKey:@"Checked"];
    }
    return self;
}
@end
