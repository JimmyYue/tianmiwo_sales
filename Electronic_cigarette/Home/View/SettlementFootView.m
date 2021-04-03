//
//  SettlementFootView.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "SettlementFootView.h"

@implementation SettlementFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setHidden];
}

- (void)setHidden {
    self.hiddenView.hidden = YES;
    self.youhuiHidden.hidden = YES;
    self.xiaojiHidden.hidden = YES;
    self.youhuiLabel.hidden = YES;
    self.shijiLabel.hidden = YES;
    self.top.constant = 10.0f;
}

- (void)setShow {
    self.hiddenView.hidden = NO;
    self.youhuiHidden.hidden = NO;
    self.xiaojiHidden.hidden = NO;
    self.youhuiLabel.hidden = NO;
    self.shijiLabel.hidden = NO;
    self.top.constant = 58.0f;
}

- (IBAction)payBtnAction:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.payTypeLabel.text = @"支付宝";
        self.payType = @"0";
    }];
    [action1 setValue:[[UIImage imageNamed:@"pay_zfb"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"微信支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.payTypeLabel.text = @"微信支付";
        self.payType = @"0";
    }];
    [action2 setValue:[[UIImage imageNamed:@"pay_weixin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"现金" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.payTypeLabel.text = @"现金";
        self.payType = @"1";
    }];
    [action3 setValue:[[UIImage imageNamed:@"pay_xianjin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [actionSheet addAction:action4];
    [self.selfView presentViewController:actionSheet animated:YES completion:nil];
}

@end
