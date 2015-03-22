//
//  ChecklistItem.m
//  Checklists
//
//  Created by baizihan on 3/13/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"
#import <UIKit/UIKit.h>

@implementation ChecklistItem
-(void)toggleChecked{
    self.checked = !self.checked;
}

-(UILocalNotification *)notificationForThisItem{
    NSArray *allNotification = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (UILocalNotification *notification in allNotification) {
        NSNumber *number = [notification.userInfo objectForKey:@"ItemId"];
        if (number != nil && [number integerValue] == self.itemId) {
            return notification;
        }
    }
    return nil;
}

-(void)scheduleNotification{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        NSLog(@"Found an existing notification %@",existingNotification);
        [[UIApplication sharedApplication]cancelLocalNotification:existingNotification];
    }
    
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending) {
        UILocalNotification *localNotification = [[UILocalNotification alloc]init];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        localNotification.alertBody = self.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = @{@"ItemId":@(self.itemId)};
        [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
        NSLog(@"Schedule notification %@ for itemId %ld",localNotification,(long)self.itemId);
    }
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

-(void)dealloc{
    UILocalNotification *existingNotification = [self notificationForThisItem]; if(existingNotification !=nil){
        NSLog(@"Removing exisint notification %@",existingNotification);
        [[UIApplication sharedApplication]cancelLocalNotification:existingNotification]; }
}

@end
