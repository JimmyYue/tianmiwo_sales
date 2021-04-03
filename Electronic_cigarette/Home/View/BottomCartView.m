//
//  BottomCartView.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import "BottomCartView.h"

@implementation BottomCartView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.settlementBtn.layer insertSublayer:self.gradientLayer atIndex:0];
    _settlementBtn.layer.cornerRadius = 28.0;
    _countBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self setListNet];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshingCount)
                                                 name:WZNotificationReloadHomeTotal
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshingCount {  // 刷新购物车数量价格
    [self setListNet];
}

- (void)setListNet {

    [NetworkHandler requestPostWithUrl:productListURL parameters:@{@"cartType":@"0", @"page":@"1", @"limit":@"500", @"order":@"desc", @"sort":@"add_time"} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            [self.countBtn setTitle:[NSString stringWithFormat:@"%@", result[@"data"][@"total"]] forState:UIControlStateNormal];
            self.allPriceLabel.text = [NSString stringWithFormat:@"¥%@", result[@"data"][@"totalPrice"]];
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
    } failure:^(NSError *error) {

    }];
}



- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = self.settlementBtn.bounds;
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:89/255.0 green:190/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:83/255.0 green:39/255.0 blue:200/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayer = gl;
        gl.cornerRadius = 28.0;
    }
    return _gradientLayer;
}

- (IBAction)settlementBtnAction:(id)sender {
    if ([self.countBtn.titleLabel.text intValue] != 0) {
        [SettlementCheckStockNet setAddNet:self.view selfView:self.selfView];
    }
}

- (IBAction)shopBtnAcrtion:(id)sender {
    ShoppingCartViewController *shopVC = [[ShoppingCartViewController alloc] init];
    [self.selfView.navigationController pushViewController:shopVC animated:YES];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
