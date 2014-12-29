//
//  Deck.h
//  CardGame
//
//  Created by baizihan on 12/15/14.
//  Copyright (c) 2014 柏梓涵个人作品. All rights reserved.
//

#ifndef CardGame_Deck_h
#define CardGame_Deck_h

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck:NSObject
-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;
-(Card *)drawRandomCard;


@end

#endif
