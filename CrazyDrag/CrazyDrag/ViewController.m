//
//  ViewController.m
//  CrazyDrag
//
//  Created by baizihan on 2/27/15.
//  Copyright (c) 2015 柏梓涵个人作品. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    int currentValue;
    int targetValue;
    int score;
    int round;
}
- (IBAction)showAlert:(id)sender;
- (IBAction)sliderMoved:(UISlider *)sender;
- (IBAction)restart:(id)sender;
- (IBAction)showInfo:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *targetLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *roundLabel;
@property (strong,nonatomic)AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

@synthesize slider;
@synthesize targetLabel;
@synthesize scoreLabel;
@synthesize audioPlayer;

-(void)playBackgroundMusic
{
    NSString *musicPath = [[NSBundle mainBundle]pathForResource:@"no" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 1;
    if (audioPlayer == nil) {
        NSString *errorInfo = [NSString stringWithString:[error description]];
        NSLog(@"the error is %@",errorInfo);
    }else{
        [audioPlayer play];
    }
}

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
    [self setMoveSliderProperties];
    [self startNewGame];
    [self updateLabels];
    [self playBackgroundMusic];
}

-(void)setMoveSliderProperties
{
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"] stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [UIImage imageNamed:@"SlideTrackRight"];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderMoved:(UISlider *)sender {
    
}

-(void)startNewGame
{
    score = 0;
    round = 0;
    [self startNewRound];
    
}

- (IBAction)restart:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 3;
    transition.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self startNewGame];
    [self updateLabels];
    [self.view.layer addAnimation:transition forKey:nil];

}

- (IBAction)showInfo:(id)sender {
    AboutViewController *controller = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
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
