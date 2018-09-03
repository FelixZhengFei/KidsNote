//
//  WeatherView.h
//  SiShi
//
//  Created by 郑强飞 on 09/10/2017.
//  Copyright © 2017 郑强飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WHWeatherType){
    WHWeatherTypeSun = 0,
    WHWeatherTypeClound = 1,
    WHWeatherTypeRain = 2,
    WHWeatherTypeRainLighting = 3,
    WHWeatherTypeSnow = 4,
    WHWeatherTypeFeng = 5,

    WHWeatherTypeOther = 6
};



@interface KDWeatherView : UIView
@property (nonatomic, strong) UIImageView *weatherBackImageView;

- (void)showWeatherAnimationWithType:(int)codeDay;
@end
