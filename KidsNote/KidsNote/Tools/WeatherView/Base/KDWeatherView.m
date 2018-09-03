//
//  WeatherView.m
//  SiShi
//
//  Created by 郑强飞 on 09/10/2017.
//  Copyright © 2017 郑强飞. All rights reserved.
//

#import "KDWeatherView.h"
#import "KDWeatherSunView.h"
#import "KDWeatherClound.h"
#import "KDWeatherRainView.h"
#import "KDWeatherSnowView.h"
#import "KDWeatherHeader.h"
#import "KDWeatherFeng.h"

@interface KDWeatherView ()

@property (nonatomic, strong) KDWeatherBaseView *displayView;
@property (nonatomic, strong) KDWeatherBaseView *willDisplayView;

@end

@implementation KDWeatherView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configueWeather];
    }
    return self;
}

- (void)configueWeather {
    //    [self showWeatherAnimationWithType:WHWeatherTypeSun];
}

#pragma mark -
#pragma mark - Priavte Method

- (void)showWeatherAnimationWithType:(int)codeDay {
    
    
    WHWeatherType weatherType = [self getWeatherType:codeDay];
    
    if (weatherType == WHWeatherTypeSun ) {
        
        KDWeatherSunView *sunView = [[KDWeatherSunView alloc] init];
        sunView.frame = self.frame;
        [self addSubview:sunView];
        self.willDisplayView = sunView;
    } else if (weatherType == WHWeatherTypeClound) {
        
        KDWeatherClound *cloundView = [[KDWeatherClound alloc] init];
        cloundView.frame = self.frame;
        [self addSubview:cloundView];
        self.willDisplayView = cloundView;
    } else if (weatherType == WHWeatherTypeFeng) {
        
        KDWeatherFeng *cloundView = [[KDWeatherFeng alloc] init];
        cloundView.frame = self.frame;
        [self addSubview:cloundView];
        self.willDisplayView = cloundView;
        
    } else if (weatherType == WHWeatherTypeRain) {
        
        KDWeatherRainView *rainView = [[KDWeatherRainView alloc] init];
        rainView.isLighting = NO;
        rainView.frame = self.frame;
        [self addSubview:rainView];
        self.willDisplayView = rainView;
    }else if (weatherType == WHWeatherTypeRainLighting) {
        
        KDWeatherRainView *rainView = [[KDWeatherRainView alloc] init];
        rainView.isLighting = YES;
        rainView.frame = self.frame;
        [self addSubview:rainView];
        self.willDisplayView = rainView;
    }else if (weatherType == WHWeatherTypeSnow) {
        self.weatherBackImageView.alpha = 0.8;
        KDWeatherSnowView *snowView = [[KDWeatherSnowView alloc] init];
        snowView.frame = self.frame;
        [self addSubview:snowView];
        self.willDisplayView = snowView;
    } else {
        
        KDWeatherBaseView *sunView = [[KDWeatherBaseView alloc] init];
        sunView.frame = self.frame;
        [self addSubview:sunView];
        self.willDisplayView = sunView;
    }
    
    
    [UIView animateWithDuration:1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (self.willDisplayView) {
                             [self.willDisplayView startAnimation];
                         }
    
                         if (self.displayView) {
                             [self.displayView stopAnimation];
                         }
                         
                     } completion:^(BOOL finished) {
                         if (finished) {
                             [self.displayView removeFromSuperview];
                             self.displayView = nil;
                             self.displayView = self.willDisplayView;
                         }
                     }];
}

#pragma mark -
#pragma mark - Tools

- (UIImage *)getGradientImage:(UIColor *)color1 and:(UIColor *)color2 {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)color1.CGColor,
                             (__bridge id)color2.CGColor];
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    gradientLayer.frame = CGRectMake(0, 0, 100, 100);
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, NO, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return gradientImage;
}


- (WHWeatherType)getWeatherType:(NSInteger)type {
    if (type >= 0 && type < 4) { //晴天
        return WHWeatherTypeSun;
        
    } else if (type >= 4 && type < 10) { //多云
        return WHWeatherTypeClound;
        
    } else if (type >= 10 && type < 20) { //雨
        if (type == 11 || type == 12 || type == 16 || type == 17 || type == 18) { //雷
            return WHWeatherTypeRainLighting;
        }
        return WHWeatherTypeRain;
        
    } else if (type >= 20 && type < 26) { //雪
        return WHWeatherTypeSnow;
        
    } else if (type >= 32 && type < 37)  { //风
        return WHWeatherTypeFeng;
        
    } else{
        return WHWeatherTypeOther;
    }
}

#pragma mark -
#pragma mark - Getter


- (UIImageView *)weatherBackImageView {
    if (!_weatherBackImageView) {
        _weatherBackImageView = [[UIImageView alloc] init];
        _weatherBackImageView.userInteractionEnabled = YES;
        _weatherBackImageView.clipsToBounds = YES;
    }
    return _weatherBackImageView;
}
@end
