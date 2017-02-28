//
//  RotationView.m
//  转
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "RotationView.h"

@interface RotationView ()

@property (nonatomic , strong) UIImageView *imageView;


@end

@implementation RotationView

static RotationView *instance;

+ (instancetype)instance
{
    if (!instance) {
        instance = [[RotationView alloc] init];
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, 100, 100);
        self.center = [[UIApplication sharedApplication].windows lastObject].center;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        //毛玻璃效果
        UIVisualEffectView *bgView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        bgView.alpha = 0.8f;
        bgView.frame = self.bounds;
        bgView.clipsToBounds = YES;
        [self addSubview:bgView];
        
        [self imageView];
    }
    return self;
}

+ (void)startAnimationInView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    CABasicAnimation *baseAniamtion = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    baseAniamtion.fromValue = @(0);
    baseAniamtion.toValue = @(M_PI * 2.0);
    baseAniamtion.removedOnCompletion = NO;
    baseAniamtion.duration = 2;
    baseAniamtion.repeatCount = 100000000000;
    [[[self instance] imageView].layer addAnimation:baseAniamtion forKey:@"rotation"];
    
    [view addSubview:[self instance]];
}

+ (void)stopAnimationInView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    [[[self instance] imageView] removeFromSuperview];
    [[self instance] removeFromSuperview];
}


- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"5"];
        [self addSubview:_imageView];
    }
    return _imageView;
}


@end
