//
//  PlayingCardView.h
//  SuperCard
//
//  Created by baizihan on 1/10/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView
@property (nonatomic)NSInteger rank;
@property (strong,nonatomic)NSString *suit;
@property (nonatomic)BOOL faceUp;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;
@end
