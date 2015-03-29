//
//  HudView.h
//  MyLocations
//
//  Created by baizihan on 3/29/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HudView : UIView

+(instancetype)hudInView:(UIView *)view animated:(BOOL)animated;
@property (nonatomic,strong)NSString *text;

@end
