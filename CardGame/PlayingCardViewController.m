//
//  PlayingCardViewController.m
//  CardGame
//
//  Created by baizihan on 12/29/14.
//  Copyright (c) 2014 柏梓涵个人作品. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

@end
