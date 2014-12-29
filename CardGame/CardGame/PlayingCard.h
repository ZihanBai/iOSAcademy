//
//  PlayingCard.h
//  CardGame
//
//  Created by baizihan on 12/16/14.
//  Copyright (c) 2014 柏梓涵个人作品. All rights reserved.
//

#ifndef CardGame_PlayingCard_h
#define CardGame_PlayingCard_h
#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSInteger)maxRank;
@end
#endif
