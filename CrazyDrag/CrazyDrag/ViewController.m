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
}
- (IBAction)showAlert:(id)sender;
- (IBAction)sliderMoved:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderMoved:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"滑动块儿的当前数值是%f",slider.value);
}
- (IBAction)showAlert:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"你好，世界" message:@"天上要掉馅儿饼啦！！" delegate:nil cancelButtonTitle:@"我来接住" otherButtonTitles:@"不，我来接住", nil] show];
}
@end
