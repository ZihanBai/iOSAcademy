//
//  CardMatchingGame.h
//  CardGame
//
//  Created by baizihan on 12/24/14.
//  Copyright (c) 2014 柏梓涵个人作品. All rights reserved.
//

#ifndef CardGame_CardMatchingGame_h
#define CardGame_CardMatchingGame_h
#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly)NSInteger score;

@end

#endif

