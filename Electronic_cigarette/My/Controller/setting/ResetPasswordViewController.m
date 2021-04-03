//
//  ResetPasswordViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat viewWidth  = self.view.bounds.size.width;
    CGFloat textFieldX = 50;
    CGFloat textFieldH = 30;
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(textFieldX, 100, viewWidth - 2 * textFieldX, textFieldH);
    textField.borderStyle = UITextBorderStyleRoundedRect; // 边框类型
    textField.font = [UIFont systemFontOfSize:1];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输原密码" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff" alpha:0.3],
    NSFontAttributeName:textField.font
    }];
    self.oldText.attributedPlaceholder = attrString;
    
    NSAttributedString *attrStringS = [[NSAttributedString alloc] initWithString:@"请输新密码" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff" alpha:0.3],
    NSFontAttributeName:textField.font
    }];
    self.passText.attributedPlaceholder = attrStringS;
    
    [self.tijiaoBtn.layer insertSublayer:self.gradientLayer atIndex:0];

    
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


- (void)setModifyPassword {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:modifyPasswordURL parameters:@{@"oldPassword":self.oldText.text, @"newPassword":self.passText.text} completion:^(id result) {
        if ([result[@"ok"] intValue] == 1) {
            [SVProgressHUD showInfoWithStatus:@"您的密码已修改!"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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

- (IBAction)tijiaoBtnAction:(id)sender {
    if ([IsBlankString isBlankString:self.oldText.text] == NO) {
        if ([IsBlankString isBlankString:self.passText.text] == NO) {
            [self setModifyPassword];
        } else {
            [SVProgressHUD showInfoWithStatus:@"请输入新码 !"];
        }
    } else {
        [SVProgressHUD showInfoWithStatus:@"请输入原密码 !"];
    }
}
@end
