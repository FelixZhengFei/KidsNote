//
//  WHWeatherFeng.m
//  KidsNote
//
//  Created by 郑强飞 on 2018/8/30.
//  Copyright © 2018年 郑强飞. All rights reserved.
//

#import "WHWeatherFeng.h"

@implementation WHWeatherFeng
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView {
    for (NSInteger i = 0; i < 30; i++) {
        NSString *imageName = [NSString stringWithFormat:@"ele_rainLine%ld",(i % 3 + 1)];
        UIImageView *snowView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        snowView.tag = 1000+i;
        
        snowView.frame = CGRectMake(0 , arc4random() % 400 + 100, arc4random()%60+50, arc4random()%30+20);
        [self addSubview:snowView];
        [snowView.layer addAnimation:[self fengAnimationWithDuration:5+arc4random()%15] forKey:nil];
    }

    
    for (int i = 0; i < 2; ++i) {
        UIImage *cloudImage;

        cloudImage = [UIImage imageNamed:[NSString stringWithFormat:@"ele_white_cloud_%d.png",i]];
        CGFloat offsetX = i * kOffsetXScreenCount / 3 * kScreenWidth - (kOffsetXScreenCount - 1) / 2.0 * kScreenWidth;
        
        UIImageView *cloudImageView = [[UIImageView alloc] initWithImage:cloudImage];
        cloudImageView.frame = CGRectMake(0, 0, 200.0 * cloudImage.size.width / cloudImage.size.height, 200);
        cloudImageView.center = CGPointMake(offsetX, arc4random()%360);
        [cloudImageView.layer addAnimation:[self cloudAnimationWithFromValue:@(offsetX) toValue:@(kOffsetXScreenCount) duration:arc4random()%50 + 50] forKey:nil];
        [self addSubview:cloudImageView];
    }
}

-(void)startAnimation
{
    [super startAnimation];
    
    self.layer.speed = 1.0;
}

-(void)stopAnimation
{
    [super stopAnimation];
    
}
@end
