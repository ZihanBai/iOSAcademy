//
//  ViewController.h
//  CardGame
//
//  Created by baizihan on 12/14/14.
//  Copyright (c) 2014 柏梓涵个人作品. All rights reserved.
//
//  abstract class. Must implement methods as discribed below.

#import <UIKit/UIKit.h>
#import "Deck.h"
@interface ViewController : UIViewController
-(Deck *)createDeck; //abstract

@end

