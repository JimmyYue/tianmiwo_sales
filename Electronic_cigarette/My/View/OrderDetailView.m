//
//  OrderDetailView.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSelectTimeViewBuy)];
        [self.pushView addGestureRecognizer:tap];
    
    [_backview.layer insertSublayer:self.gradientLayer atIndex:0];
}

- (void)dismissSelectTimeViewBuy {
    LogisticsDetailViewController *logVC = [[LogisticsDetailViewController alloc] init];
    logVC.detailDic = _detailDic;
    [self.selfView.navigationController pushViewController:logVC animated:YES];
}


- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, kDeviceWidth, 120);
        gl.startPoint = CGPointMake(-0.01, -0.06);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:184/255.0 green:17/255.0 blue:167/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:107/255.0 green:27/255.0 blue:161/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayer = gl;
    }
    return _gradientLayer;
}

- (IBAction)backBtnAction:(id)sender {
    [self.selfView.navigationController popViewControllerAnimated:YES];
}

@end
