//
//  ShoppingCartListBottomView.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "ShoppingCartListBottomView.h"

@implementation ShoppingCartListBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.jisuanBtn.layer insertSublayer:self.gradientLayer atIndex:0];
}

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, 115, 40);
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:89/255.0 green:190/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:83/255.0 green:39/255.0 blue:200/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayer = gl;
        gl.cornerRadius = 8.0;
    }
    return _gradientLayer;
}


@end
