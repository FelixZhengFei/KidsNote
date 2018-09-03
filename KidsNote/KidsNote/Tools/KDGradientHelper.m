//
//  KDGradientHelper.m
//  Example
//
//  Created by 郑强飞 on 3/20/17.
//  Copyright © 2017 郑强飞. All rights reserved.
//

#import "KDGradientHelper.h"

#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFronHSB(h,s,b)               [UIColor colorWithHue:h saturation:s brightness:b alpha:1.0f]


@implementation KDGradientHelper




+ (void)addGradientChromatoAnimationForLableText:(UIView *)parentView lable:(UILabel *)lable startIndex:(int )startIndex
{
    if (parentView == nil || lable == nil) {
        return;
    }
    
    [parentView addSubview:lable];
    
    CAGradientLayer *chromatoLayer = [CAGradientLayer layer];
    [chromatoLayer setColors:@[(__bridge id)UIColorFronHSB(0.63, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.75, 0.69, 0.88).CGColor]];
    [chromatoLayer setStartPoint:CGPointMake(0, 0)];
    [chromatoLayer setEndPoint:CGPointMake(1, 0)];
    chromatoLayer.locations = @[@(0.0f) ,@(1.0f)];
    [chromatoLayer setFrame:parentView.frame];
    
    CAKeyframeAnimation *chromateAnimate;
    
    if (startIndex == 0) {
        chromateAnimate = [self createGradientChromatoKeyAnimation_0];
    } else if (startIndex == 1) {
        chromateAnimate = [self createGradientChromatoKeyAnimation_1];
    } else if (startIndex == 2) {
        chromateAnimate = [self createGradientChromatoKeyAnimation_2];
    } else {
        chromateAnimate = [self createGradientChromatoKeyAnimation_3];
    }
    
    [chromatoLayer addAnimation:chromateAnimate forKey:@"chromateAnimate"];
    
    [parentView.layer addSublayer:chromatoLayer];
    chromatoLayer.mask = lable.layer;
    chromatoLayer.frame = chromatoLayer.bounds;
}


#pragma mark - private method

+ (CAKeyframeAnimation *)createGradientChromatoKeyAnimation_0 {
    CAKeyframeAnimation *chromateAnimate = [CAKeyframeAnimation animationWithKeyPath:@"colors"];
    
    chromateAnimate.values = @[@[(__bridge id)UIColorFronHSB(0.63, 0.69, 0.88).CGColor,
                                 (__bridge id)UIColorFronHSB(0.75, 0.59, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.73, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.85, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.98, 0.59, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.95, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.63, 0.59, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.75, 0.69, 0.88).CGColor]];
    chromateAnimate.keyTimes = @[@0, @0.41,@78,@1];
    chromateAnimate.duration = 3;
    chromateAnimate.removedOnCompletion = NO;
    chromateAnimate.repeatCount = MAXFLOAT;
    
    return chromateAnimate;
}

+ (CAKeyframeAnimation *)createGradientChromatoKeyAnimation_1 {
    CAKeyframeAnimation *chromateAnimate = [CAKeyframeAnimation animationWithKeyPath:@"colors"];
    
    chromateAnimate.values = @[@[(__bridge id)UIColorFronHSB(0.98, 0.49, 0.78).CGColor,
                                 (__bridge id)UIColorFronHSB(0.45, 0.49, 0.78).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.4, 0.49, 0.78).CGColor, (__bridge id)UIColorFronHSB(0.52, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.1, 0.49, 0.78).CGColor, (__bridge id)UIColorFronHSB(0.62, 0.69, 0.78).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.98, 0.49, 0.78).CGColor, (__bridge id)UIColorFronHSB(0.45, 0.49, 0.78).CGColor]];
    chromateAnimate.keyTimes = @[@0,@35,@0.65, @1];
    chromateAnimate.duration = 3;
    chromateAnimate.removedOnCompletion = NO;
    chromateAnimate.repeatCount = MAXFLOAT;
    
    return chromateAnimate;
}

+ (CAKeyframeAnimation *)createGradientChromatoKeyAnimation_2 {
    CAKeyframeAnimation *chromateAnimate = [CAKeyframeAnimation animationWithKeyPath:@"colors"];
    
    chromateAnimate.values = @[
                               @[(__bridge id)UIColorFronHSB(1, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.12, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.1, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.22, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.2, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.32, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(1, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.12, 0.69, 0.88).CGColor]];
    chromateAnimate.keyTimes = @[@0, @0.31, @0.72,@1];
    chromateAnimate.duration = 3;
    chromateAnimate.removedOnCompletion = NO;
    chromateAnimate.repeatCount = MAXFLOAT;
    
    return chromateAnimate;
}

+ (CAKeyframeAnimation *)createGradientChromatoKeyAnimation_3 {
    CAKeyframeAnimation *chromateAnimate = [CAKeyframeAnimation animationWithKeyPath:@"colors"];
    
    chromateAnimate.values = @[
                               @[(__bridge id)UIColorFronHSB(0.2, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.82, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.3, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.72, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.4, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.62, 0.69, 0.88).CGColor],
                               @[(__bridge id)UIColorFronHSB(0.2, 0.69, 0.88).CGColor, (__bridge id)UIColorFronHSB(0.82, 0.69, 0.88).CGColor]
                               ];
    chromateAnimate.keyTimes = @[@0, @0.1, @0.2, @0.25, @0.35, @0.37, @0.47, @0.57, @0.67, @0.77, @0.87, @0.97, @1];
    chromateAnimate.duration = 3;
    chromateAnimate.removedOnCompletion = NO;
    chromateAnimate.repeatCount = MAXFLOAT;
    
    return chromateAnimate;
}

@end
