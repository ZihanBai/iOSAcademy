//
//  ViewController.m
//  CrazyDrag
//
//  Created by baizihan on 2/27/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int currentValue;
    int targetValue;
    int score;
    int round;
}
- (IBAction)showAlert:(id)sender;
- (IBAction)sliderMoved:(UISlider *)sender;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;

@end

@implementation ViewController

@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;

-(void)startNewRound
{
    targetValue = 1 + (arc4random() % 100);
    currentValue = 50;
    self.slider.value = currentValue;
    round += 1;
}

-(int)getDeffence
{
    return abs(currentValue - targetValue);
}

-(void)updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d",targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",round];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    currentValue = self.slider.value;
//    targetValue = 1 + (arc4random() % 100);
    [self startNewRound];
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderMoved:(UISlider *)sender {
//    UISlider *slider = (UISlider *)sender;
//    //NSLog(@"滑动块儿的当前数值是%f",slider.value);
//    currentValue = (int)lroundf(sender.value);
    int deffrence = [self getDeffence];
    int points = 100 - deffrence;
    score += points;
    
//    NSString *message = [NSString stringWithFormat:@"当前数值是%d,我们的目标数值是%d,我们的差距是%d",(int)lroundf(sender.value),targetValue,deffrence];
    NSString *message = [NSString stringWithFormat:@"您的得分是:%d",points];
    [[[UIAlertView alloc] initWithTitle:@"你好，世界" message:message delegate:nil cancelButtonTitle:@"安大是个好学校" otherButtonTitles:nil, nil]show];
    [self startNewRound];
    [self updateLabels];
}
- (IBAction)showAlert:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"你好，世界" message:@"天上要掉馅儿饼啦！！" delegate:nil cancelButtonTitle:@"我来接住" otherButtonTitles:@"不，我来接住", nil] show];
}

@end
