//
//  AddAddressViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"选择地址";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.addBtn.layer insertSublayer:self.gradientLayer atIndex:0];
    
    CGFloat viewWidth  = self.view.bounds.size.width;
    CGFloat textFieldX = 50;
    CGFloat textFieldH = 30;
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(textFieldX, 100, viewWidth - 2 * textFieldX, textFieldH);
    textField.borderStyle = UITextBorderStyleRoundedRect; // 边框类型
    textField.font = [UIFont systemFontOfSize:14];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入收货人手机号码" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff" alpha:0.3],
    NSFontAttributeName:textField.font
    }];
    self.phoneText.attributedPlaceholder = attrString;
    
    NSAttributedString *attrString1 = [[NSAttributedString alloc] initWithString:@"请输入收货人姓名" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff" alpha:0.3],
    NSFontAttributeName:textField.font
    }];
    self.shouhuoText.attributedPlaceholder = attrString1;
    
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"请输入收货详细地址" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff" alpha:0.3],
    NSFontAttributeName:textField.font
    }];
    self.addressText.attributedPlaceholder = attrString2;
    
    if (_shippingAddressModel) {
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
        [rightButton setTitle:@"删除" forState:UIControlStateNormal];
        rightButton.titleLabel.textColor = [UIColor whiteColor];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        self.province = [NSString stringWithFormat:@"%@", _shippingAddressModel.province];
        self.provinceName = [NSString stringWithFormat:@"%@", _shippingAddressModel.provinceName];
        self.city = [NSString stringWithFormat:@"%@", _shippingAddressModel.city];
        self.cityName = [NSString stringWithFormat:@"%@", _shippingAddressModel.cityName];
        self.country = [NSString stringWithFormat:@"%@", _shippingAddressModel.country];
        self.countryName = [NSString stringWithFormat:@"%@", _shippingAddressModel.countryName];
        self.addressText.text = [NSString stringWithFormat:@"%@", _shippingAddressModel.addressDetail];
        self.phoneText.text = [NSString stringWithFormat:@"%@", _shippingAddressModel.receiverPhone];
        self.shouhuoText.text = [NSString stringWithFormat:@"%@", _shippingAddressModel.receiver];
        [self.areaBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@", _shippingAddressModel.provinceName, _shippingAddressModel.cityName, _shippingAddressModel.countryName] forState:UIControlStateNormal];
    }
    
}

- (void)rightBtnAction {
    [self setAddress:@{@"addressId":[NSString stringWithFormat:@"%@", _shippingAddressModel.addressId]}];
}

- (IBAction)addBtnAction:(id)sender {
    if ([IsBlankString isBlankString:self.shouhuoText.text] == NO) {
        if ([IsBlankString isBlankString:self.phoneText.text] == NO) {
            if ([XYCommon isMobileNumber:_phoneText.text] == NO) {
                [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号码!"];
            } else {
                if ([IsBlankString isBlankString:self.province] == NO) {
                    if ([IsBlankString isBlankString:self.addressText.text] == NO) {
                        if (_shippingAddressModel) {
                            [self setAddress:@{@"province":self.province, @"provinceName":self.province, @"city":self.city, @"cityName":self.cityName, @"country":self.country, @"countryName":self.countryName, @"addressDetail":self.addressText.text, @"receiver":self.shouhuoText.text, @"receiverPhone":self.phoneText.text, @"memberPhone":self.memberPhone, @"addressId":[NSString stringWithFormat:@"%@", _shippingAddressModel.addressId]}];
                        } else {
                            [self setAddress:@{@"province":self.province, @"provinceName":self.province, @"city":self.city, @"cityName":self.cityName, @"country":self.country, @"countryName":self.countryName, @"addressDetail":self.addressText.text, @"receiver":self.shouhuoText.text, @"receiverPhone":self.phoneText.text, @"memberPhone":self.memberPhone}];
                        }
                    } else {
                        [SVProgressHUD showInfoWithStatus:@"请填写详细地址!"];
                    }
                } else {
                    [SVProgressHUD showInfoWithStatus:@"请选择所在地区!"];
                }
            }
        } else {
            [SVProgressHUD showInfoWithStatus:@"请填写手机号码!"];
        }
    } else {
        [SVProgressHUD showInfoWithStatus:@"请填写收货人!"];
    }
}

- (void)setAddress:(NSDictionary *)dic {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    NSString *url = addAddressURL;
    if (_shippingAddressModel) {
        url = updateAddressURL;
        if (dic.count < 2) {
            url = deleteAddressURL;
        }
    }
    
    [NetworkHandler requestPostWithUrl:url parameters:dic completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            self.block(@"reload");
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (IBAction)areaBtnAction:(id)sender {
    CitySelectorView * addressPickerView = [CitySelectorView pickerView];
    addressPickerView.selectResultBlock = ^(HBLocationModel * _Nullable province, HBLocationModel * _Nullable city, HBLocationModel * _Nullable area) {
        [self.areaBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@", province.name, city.name, area.name] forState:UIControlStateNormal];
        self.province = [NSString stringWithFormat:@"%@", province.code];
        self.provinceName = [NSString stringWithFormat:@"%@", province.name];
        self.city = [NSString stringWithFormat:@"%@", city.code];
        self.cityName = [NSString stringWithFormat:@"%@", city.name];
        self.country = [NSString stringWithFormat:@"%@", area.code];
        self.countryName = [NSString stringWithFormat:@"%@", area.name];
    };
    [addressPickerView show];
}

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, kDeviceWidth - 20, 50);
        gl.startPoint = CGPointMake(0, 0.5);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:85/255.0 green:189/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:78/255.0 green:42/255.0 blue:173/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayer = gl;
        gl.cornerRadius = 10.0;
    }
    return _gradientLayer;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





@end
