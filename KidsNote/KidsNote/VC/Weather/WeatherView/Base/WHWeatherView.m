//
//  WeatherView.m
//  SiShi
//
//  Created by whbalzac on 09/10/2017.
//  Copyright © 2017 whbalzac. All rights reserved.
//

#import "WHWeatherView.h"
#import "WHWeatherSunView.h"
#import "WHWeatherClound.h"
#import "WHWeatherRainView.h"
#import "WHWeatherSnowView.h"
#import "WHWeatherHeader.h"
#import "WHWeatherFeng.h"

@interface WHWeatherView ()

@property (nonatomic, strong) WHWeatherBaseView *displayView;
@property (nonatomic, strong) WHWeatherBaseView *willDisplayView;

@end

@implementation WHWeatherView

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
    UIImage *backImage = [self getBackgourImage:codeDay];
    
    if (weatherType == WHWeatherTypeSun ) {
        
        WHWeatherSunView *sunView = [[WHWeatherSunView alloc] init];
        sunView.frame = self.frame;
        [self addSubview:sunView];
        self.willDisplayView = sunView;
    } else if (weatherType == WHWeatherTypeClound) {
        
        WHWeatherClound *cloundView = [[WHWeatherClound alloc] init];
        cloundView.frame = self.frame;
        [self addSubview:cloundView];
        self.willDisplayView = cloundView;
    } else if (weatherType == WHWeatherTypeFeng) {
        
        WHWeatherFeng *cloundView = [[WHWeatherFeng alloc] init];
        cloundView.frame = self.frame;
        [self addSubview:cloundView];
        self.willDisplayView = cloundView;
        
    } else if (weatherType == WHWeatherTypeRain) {
        
        WHWeatherRainView *rainView = [[WHWeatherRainView alloc] init];
        rainView.isLighting = NO;
        rainView.frame = self.frame;
        [self addSubview:rainView];
        self.willDisplayView = rainView;
    }else if (weatherType == WHWeatherTypeRainLighting) {
        
        WHWeatherRainView *rainView = [[WHWeatherRainView alloc] init];
        rainView.isLighting = YES;
        rainView.frame = self.frame;
        [self addSubview:rainView];
        self.willDisplayView = rainView;
    }else if (weatherType == WHWeatherTypeSnow) {
        self.weatherBackImageView.alpha = 0.8;
        WHWeatherSnowView *snowView = [[WHWeatherSnowView alloc] init];
        snowView.frame = self.frame;
        [self addSubview:snowView];
        self.willDisplayView = snowView;
    } else {
        
        WHWeatherBaseView *sunView = [[WHWeatherBaseView alloc] init];
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
                         if (backImage) {
                             self.weatherBackImageView.image = backImage;
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

- (UIImage *)getBackgourImage:(NSInteger)codeDay {
    UIImage *backImage = [UIImage imageNamed:@"rain_bg"];
//    if (codeDay >= 0 && codeDay < 4) { //晴天
//        backImage = [self getGradientImage:UIColorFromRGB(0,191,255) and:UIColorFromRGB(240,255,255)];
//        
//    } else if (codeDay >= 4 && codeDay < 10) { //多云
//        backImage = [self getGradientImage:UIColorFromRGB(0,191,255) and:UIColorFromRGB(173,216,230)];
//        
//    } else if (codeDay >= 10 && codeDay < 20) { //雨
//        if (codeDay == 11 || codeDay == 12 || codeDay == 16 || codeDay == 17 || codeDay == 18) { //雷
//            backImage = [self getGradientImage:UIColorFromRGB(135,206,235) and:UIColorFromRGB(190,200,210)];
//        } else {
//            //雨
//            backImage = [self getGradientImage:UIColorFromRGB(73, 115, 146) and:UIColorFromRGB(240,255,255)];
//        }
//        
//    } else if (codeDay >= 20 && codeDay < 26) { //雪
//        backImage = [UIImage imageNamed:@"snow2"];
//        
//    } else if (codeDay >= 26 && codeDay < 30)  { //沙尘暴
//        
//    } else if (codeDay >= 30 && codeDay < 32)  { //雾霾
//        
//    } else if (codeDay >= 32 && codeDay < 37)  { //风
//        backImage = [self getGradientImage:UIColorFromRGB(30,144,255) and:UIColorFromRGB(245,245,245)];
//        
//    } else {
//    }
    
    return backImage;
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
