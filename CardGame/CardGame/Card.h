//
//  Card.h
//  CardGame
//
//  Created by baizihan on 12/14/14.
//  Copyright (c) 2014 柏梓涵个人作品. All rights reserved.
//

#ifndef CardGame_Card_h
#define CardGame_Card_h
#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;
@property (nonatomic,getter=isChosen)BOOL chosen;
@property (nonatomic,getter=isMatched)BOOL matched;

-(int)match:(NSArray *)otherCards;

@end




#endif
