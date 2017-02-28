//
//  ViewController.m
//  转
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "ViewController.h"
#import "RotationView.h"
#import "LoadHUDView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"5"];
    self.view.layer.contents = (__bridge id _Nullable)(image.CGImage);
    
//    [RotationView startAnimationInView:self.view];
    
    [LoadHUDView startAnimationInView:self.view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [RotationView stopAnimationInView:self.view];
    
    [LoadHUDView dissmissAnimation];
}


@end
