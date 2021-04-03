//
//  SettlementHeardView.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "SettlementHeardView.h"

@implementation SettlementHeardView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat viewWidth  = kDeviceWidth - 80;
    CGFloat textFieldX = 50;
    CGFloat textFieldH = 30;
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(textFieldX, 100, viewWidth - 2 * textFieldX, textFieldH);
    textField.borderStyle = UITextBorderStyleRoundedRect; // 边框类型
    textField.font = [UIFont systemFontOfSize:14];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入会员手机号" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff" alpha:0.4],
    NSFontAttributeName:textField.font
    }];
    self.huiyuanText.attributedPlaceholder = attrString;
    
}


- (IBAction)chuhuoBtnAction:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"云仓出货" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.chuhuoTypeLabel.text = @"云仓出货";
    }];
    [action1 setValue:[[UIImage imageNamed:@"pay_yuncang"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    NSString *title = @"线下出货";
    if ([IsBlankString isBlankString:self.inventory] == NO) {
        title = @"线下出货 (库存不足)";
    }
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([title isEqualToString:@"线下出货"]) {
            self.chuhuoTypeLabel.text = @"线下出货";
        }
    }];
    [action2 setValue:[[UIImage imageNamed:@"pay_xianxia"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [self.selfView presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)shouhuoBtnAction:(id)sender {
    if ([IsBlankString isBlankString:self.huiyuanText.text] == NO) {
        if ([XYCommon isMobileNumber:_huiyuanText.text] == NO) {
            [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号码!"];
        } else {
            ShippingAddressViewController *addressVC = [[ShippingAddressViewController alloc] init];
            addressVC.memberPhone = self.huiyuanText.text;
            [addressVC setBlock:^(ShippingAddressModel * _Nonnull shippingAddressModel) {
                self.shouhuoLabel.text = [NSString  stringWithFormat:@"%@ %@ %@%@%@%@", shippingAddressModel.receiver, shippingAddressModel.receiverPhone, shippingAddressModel.provinceName, shippingAddressModel.cityName, shippingAddressModel.countryName, shippingAddressModel.addressDetail];
                self.addressId = [NSString stringWithFormat:@"%@", shippingAddressModel.addressId];
            }];
            [self.selfView.navigationController pushViewController:addressVC animated:YES];
        }
    } else {
        [SVProgressHUD showInfoWithStatus:@"请填写会员手机号码后选择地址!"];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
