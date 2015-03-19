//
//  Checklist.h
//  Checklists
//
//  Created by baizihan on 3/18/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject<NSCoding>
@property (nonatomic,copy)NSString *name;
@property (nonatomic,strong)NSMutableArray *items;
@end
