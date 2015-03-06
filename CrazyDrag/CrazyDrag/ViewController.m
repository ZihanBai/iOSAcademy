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

    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}

- (IBAction)showAlert:(id)sender {
    int deffrence = [self getDeffence];
    int points = 100 - deffrence;
    score += points;
    NSString *title;
    if (deffrence == 0) {
        title = @"太棒啦！";
        points += 100;
    }else if (deffrence < 5)
    {
        title = @"very good!";
        if (deffrence == 1) {
            points += 50;
        }
    }else if (deffrence < 10)
    {
        title = @"good!";
    }else
    {
        title = @"bad!";
    }
    NSString *message = [NSString stringWithFormat:@"您的得分是:%d",points];
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"安大是个好学校" otherButtonTitles:nil, nil]show];
}

@end
