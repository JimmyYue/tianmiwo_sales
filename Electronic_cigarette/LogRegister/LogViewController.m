//
//  LogViewController.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/9.
//

#import "LogViewController.h"

@interface LogViewController ()
{
    int _curTime;//倒计时 开始时间
}
@end

@implementation LogViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.phoneText becomeFirstResponder];  // 编辑状态
    [self.phoneText setFormat:YES];
    self.phoneText.cdelegate = self;
    
    self.selectedBtn.selected = YES;
    
    CGFloat viewWidth  = self.view.bounds.size.width;
    CGFloat textFieldX = 50;
    CGFloat textFieldH = 30;
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(textFieldX, 100, viewWidth - 2 * textFieldX, textFieldH);
    textField.borderStyle = UITextBorderStyleRoundedRect; // 边框类型
    textField.font = [UIFont systemFontOfSize:17];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入账号名" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff" alpha:0.3],
    NSFontAttributeName:textField.font
    }];
    self.phoneText.attributedPlaceholder = attrString;
    
    NSAttributedString *attrStringS = [[NSAttributedString alloc] initWithString:@"请输入登录密码" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff" alpha:0.3],
    NSFontAttributeName:textField.font
    }];
    self.codeText.attributedPlaceholder = attrStringS;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"log_clear"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(phoneAcrion) forControlEvents:UIControlEventTouchUpInside];
    self.phoneText.rightView = button;
    self.phoneText.rightViewMode = UITextFieldViewModeWhileEditing;
    UIButton *buttonP = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonP setImage:[UIImage imageNamed:@"log_clear"] forState:UIControlStateNormal];
    [buttonP addTarget:self action:@selector(passAcrion) forControlEvents:UIControlEventTouchUpInside];
    self.codeText.rightView = buttonP;
    self.codeText.rightViewMode = UITextFieldViewModeWhileEditing;
    
    self.codeText.delegate = self;
    
    [_loginBtn addTarget:self action:@selector(buttonBackGroundHighlightedUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [_loginBtn addTarget:self action:@selector(buttonBackGroundHighlightedDown:) forControlEvents:UIControlEventTouchDown];
}

- (void)phoneAcrion {
    self.phoneText.text = @"";
}

- (void)passAcrion {
    self.codeText.text = @"";
}

- (void)buttonBackGroundHighlightedDown:(UIButton *)button {
    
    if (_phoneText.yhl_text.length > 0 && _codeText.text.length > 0) {
        
        button.backgroundColor = [UIColor colorWithHexString:@"00AAE6"];
        
        if ([XYCommon isMobileNumber:_phoneText.yhl_text] == NO) {
            [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号码!"];
        } else {
            if (self.selectedBtn.selected == YES) {
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
                hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
                hud.bezelView.color = [UIColor clearColor];
                
                [NetworkHandler requestPostWithUrl:loginURL parameters:@{@"username":_phoneText.yhl_text, @"password":_codeText.text} completion:^(id result) {
                    
                    if ([result[@"ok"] intValue] == 1) {
                        
                        [UMessage setAlias:[NSString stringWithFormat:@"%@", result[@"data"][@"userId"]] type:@"tianmiwo" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
                        }];
                        
                        [XYCommon SetUserDefault:@"Token" byValue:result[@"data"][@"token"]];
                        
                        if ([self->_outLogin isEqualToString:@"yes"]) {
                            [self.navigationController popViewControllerAnimated:YES];
                        } else {
                            HomeViewController *bindingVC = [[HomeViewController alloc] init];
                            [self.navigationController pushViewController:bindingVC animated:NO];
                        }
                        
                        [self setUserInfo];
                        
                    } else {
                        [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
                    }
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                } failure:^(NSError *error) {
                    NSLog(@"%@", error);
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                }];
            } else {
                [SVProgressHUD showInfoWithStatus:@"请勾选服务协议!"];
            }
        }
    }
}

- (void)buttonBackGroundHighlightedUp:(UIButton *)button {
    button.backgroundColor = [UIColor colorWithHexString:@"00BDFF"];
}

- (IBAction)agreementnBtnAction:(id)sender {
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.type = @"login";
    webVC.url = agreementHtml;
    [webVC setBlockAgree:^(bool agree) {
        if (agree == true) {
            self.selectedBtn.selected = YES;
        }
    }];
    [self presentViewController:webVC animated:YES completion:nil];
}


- (IBAction)selectedBtnAction:(id)sender {
    if (self.selectedBtn.selected == NO) {
        self.selectedBtn.selected = YES;
    } else {
        self.selectedBtn.selected = NO;
    }
}

- (void)dealloc {
   
}

- (void)setUserInfo {

    [NetworkHandler requestPostWithUrl:userInfoURL parameters:nil completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            [XYCommon SetUserDefault:@"Avatar" byValue:result[@"data"][@"avatar"]];
            [XYCommon SetUserDefault:@"NickName" byValue:result[@"data"][@"nickName"]];
            [XYCommon SetUserDefault:@"Phone" byValue:result[@"data"][@"phone"]];
            [XYCommon SetUserDefault:@"Position" byValue:result[@"data"][@"position"]];
            [XYCommon SetUserDefault:@"RoleId" byValue:result[@"data"][@"roleId"]];
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
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
