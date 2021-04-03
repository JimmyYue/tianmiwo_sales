//
//  SettementBottomView.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "SettementBottomView.h"

@implementation SettementBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionBtn.layer insertSublayer:self.gradientLayer atIndex:0];
}

- (IBAction)modifyBtnAction:(id)sender {
    ModifyPriceViewController *priceVC = [[ModifyPriceViewController alloc] init];
    priceVC.allPrice = self.allPrice;
    [priceVC setBlock:^(NSString * _Nonnull price) {
        if ([IsBlankString isBlankString:price] == NO) {
            if ([self.allPrice floatValue] == [price floatValue]) {
                [self.settlementFootView setHidden];
                self.settlementFootView.youhuiLabel.text = @"¥0";
                self.settlementFootView.shijiLabel.text = @"¥0";
            } else {
                [self.settlementFootView setShow];
                self.settlementFootView.youhuiLabel.text = [NSString stringWithFormat:@"¥%0.2f", [self.allPrice floatValue] - [price floatValue]];
                self.settlementFootView.shijiLabel.text = [NSString stringWithFormat:@"¥%@", price];
            }
        }
    }];
    [self.selfView.navigationController pushViewController:priceVC animated:YES];
}

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, (kDeviceWidth - 30) / 2, 50);
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:89/255.0 green:190/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:83/255.0 green:39/255.0 blue:200/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayer = gl;
        gl.cornerRadius = 8.0;
    }
    return _gradientLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
