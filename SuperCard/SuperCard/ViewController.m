//
//  ViewController.m
//  SuperCard
//
//  Created by baizihan on 1/10/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playCardView;
@property (strong,nonatomic) Deck *deck;
@end

@implementation ViewController

-(Deck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc]init];
    }
    return _deck;
}

-(void)drawRandomPlayingCard
{
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.playCardView.suit = playingCard.suit;
        self.playCardView.rank = playingCard.rank;
    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    if (self.playCardView.faceUp) {
        [self drawRandomPlayingCard];
    }
    self.playCardView.faceUp = !self.playCardView.faceUp;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.playCardView.suit = @"❤️";
    self.playCardView.rank = 13;
    [self.playCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self.playCardView action:@selector(pinch:)]];
}


@end
