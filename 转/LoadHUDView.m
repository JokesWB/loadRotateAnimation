//
//  LoadHUDView.m
//  转
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "LoadHUDView.h"

#define kRadius 10  //小球半径
#define kDiameter 2.0 * kRadius //小球直径
#define kDuration 1.6   //动画时间

@interface LoadHUDView ()

@property (nonatomic , strong) UIView *ball1;
@property (nonatomic , strong) UIView *ball2;
@property (nonatomic , strong) UIView *ball3;
@property (nonatomic , strong) UIView *aView;
@property (nonatomic , assign) BOOL isRemove;  //是否移除掉
//@property (nonatomic , strong) UILabel *label;

@end

@implementation LoadHUDView

static LoadHUDView *instance;

+ (instancetype)instance
{
    if (!instance) {
        instance = [[LoadHUDView alloc] init];
    }
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, 150, 150);
        self.center = [[UIApplication sharedApplication].windows lastObject].center;
        self.layer.cornerRadius = kRadius;
        self.layer.masksToBounds = YES;
        
        //毛玻璃效果
        UIVisualEffectView *bgView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        bgView.alpha = 0.8;
        bgView.frame = self.bounds;
        bgView.clipsToBounds = YES;
        [self addSubview:bgView];
        
//        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30)];
//        self.label.text = @"正在加载...";
//        self.label.font = [UIFont systemFontOfSize:16];
//        self.label.textAlignment = NSTextAlignmentCenter;
//        self.label.textColor = [UIColor whiteColor];
//        [self addSubview:self.label];
        //添加小球
        [self addBalls];
        
    }
    return self;
}

- (void)addBalls
{
    CGFloat centerX = self.frame.size.width * 0.5;
    CGFloat centerY = self.frame.size.height * 0.5;  //小球的origin.y
    //第一个球
    self.ball1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDiameter, kDiameter)];
    self.ball1.center = CGPointMake(centerX - 2 * kRadius, centerY);
    self.ball1.layer.cornerRadius = kRadius;
    self.ball1.layer.masksToBounds = YES;
    self.ball1.backgroundColor = [UIColor blackColor];
    [self addSubview:self.ball1];
    
    //第二个球，中间的球（不动）
    self.ball2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDiameter, kDiameter)];
    self.ball2.center = CGPointMake(centerX, centerY);
    self.ball2.layer.cornerRadius = kRadius;
    self.ball2.layer.masksToBounds = YES;
    self.ball2.backgroundColor = [UIColor redColor];
    [self addSubview:self.ball2];
    
    //第二个球
    self.ball3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDiameter, kDiameter)];
    self.ball3.center = CGPointMake(centerX + 2 * kRadius, centerY);
    self.ball3.layer.cornerRadius = kRadius;
    self.ball3.layer.masksToBounds = YES;
    self.ball3.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.ball3];
}

//开始动画
+ (void)startAnimationInView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    LoadHUDView *hudView = [self instance];
    [view addSubview:hudView];
    
    hudView.aView = view;
    
    CGFloat centerX = hudView.frame.size.width * 0.5;
    CGFloat centerY = hudView.frame.size.height * 0.5;  //小球的origin.y
    //第一个小球的动画曲线
    UIBezierPath *pathBall_1 = [UIBezierPath bezierPath];
    [pathBall_1 moveToPoint:CGPointMake(centerX - 2 * kRadius, centerY)];
    [pathBall_1 addArcWithCenter:CGPointMake(centerX, centerY) radius:kDiameter startAngle:M_PI endAngle:M_PI * 2.0 clockwise:NO];
    UIBezierPath *pathBall_11 = [UIBezierPath bezierPath];
    [pathBall_11 addArcWithCenter:CGPointMake(centerX, centerY) radius:kDiameter startAngle:0 endAngle:M_PI clockwise:NO];
    [pathBall_1 appendPath:pathBall_11];
    
    //让第一个小球做圆环运动
    CAKeyframeAnimation *animation_ball_1=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_1.path = pathBall_1.CGPath;
    animation_ball_1.removedOnCompletion = NO;
    animation_ball_1.fillMode = kCAFillModeForwards;
    animation_ball_1.calculationMode = kCAAnimationCubic;
    animation_ball_1.repeatCount = 1;
    animation_ball_1.duration = kDuration;
    animation_ball_1.delegate = hudView;
    animation_ball_1.autoreverses = NO;
    animation_ball_1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [hudView.ball1.layer addAnimation:animation_ball_1 forKey:@"animation"];
    
    
    //第三个小球的动画曲线
    UIBezierPath *pathBall_3 = [UIBezierPath bezierPath];
    [pathBall_3 moveToPoint:CGPointMake(centerX + 2 * kRadius, centerY)];
    [pathBall_3 addArcWithCenter:CGPointMake(centerX, centerY) radius:kDiameter startAngle:0 endAngle:M_PI clockwise:NO];
    UIBezierPath *pathBall_33 = [UIBezierPath bezierPath];
    [pathBall_33 addArcWithCenter:CGPointMake(centerX, centerY) radius:kDiameter startAngle:M_PI endAngle:M_PI * 2.0 clockwise:NO];
    [pathBall_3 appendPath:pathBall_33];
    
    //让第三个小球做圆环运动
    CAKeyframeAnimation *animation_ball_3=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_ball_3.path = pathBall_3.CGPath;
    animation_ball_3.removedOnCompletion = NO;
    animation_ball_3.fillMode = kCAFillModeForwards;
    animation_ball_3.calculationMode = kCAAnimationCubic;
    animation_ball_3.repeatCount = 1;
    animation_ball_3.duration = kDuration;
    animation_ball_3.autoreverses = NO;
    animation_ball_3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [hudView.ball3.layer addAnimation:animation_ball_3 forKey:@"animation1"];
}

//结束动画
+ (void)dissmissAnimation
{
    LoadHUDView *hudView = [self instance];
    [hudView removeFromSuperview];
    hudView.isRemove = YES;
}

#pragma mark - 动画代理
- (void)animationDidStart:(CAAnimation *)anim
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.ball1.transform = CGAffineTransformMakeTranslation(-kDiameter, 0);
        self.ball1.transform = CGAffineTransformScale(self.ball1.transform, 0.7, 0.7);
        
        self.ball3.transform = CGAffineTransformMakeTranslation(kDiameter, 0);
        self.ball3.transform = CGAffineTransformScale(self.ball3.transform, 0.7, 0.7);
        
        self.ball2.transform = CGAffineTransformScale(self.ball2.transform, 0.7, 0.7);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn  | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.ball1.transform = CGAffineTransformIdentity;
            self.ball3.transform = CGAffineTransformIdentity;
            self.ball2.transform = CGAffineTransformIdentity;
        } completion:NULL];
        
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.isRemove) return;
    [[self class] startAnimationInView:self.aView];
}

@end
