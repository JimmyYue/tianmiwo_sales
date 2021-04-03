//
//  ModifyPriceViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "ModifyPriceViewController.h"

@interface ModifyPriceViewController ()

@end

@implementation ModifyPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"选择地址";
    self.view.backgroundColor = [UIColor blackColor];
    self.priceText.delegate = self;
    [self.tijiaoBtn.layer insertSublayer:self.gradientLayer atIndex:0];
    
    CGFloat viewWidth  = kDeviceWidth - 80;
    CGFloat textFieldX = 50;
    CGFloat textFieldH = 30;
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(textFieldX, 100, viewWidth - 2 * textFieldX, textFieldH);
    textField.borderStyle = UITextBorderStyleRoundedRect; // 边框类型
    textField.font = [UIFont systemFontOfSize:15];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入修改后的价格" attributes:
    @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff" alpha:0.3],
    NSFontAttributeName:textField.font
    }];
    self.priceText.attributedPlaceholder = attrString;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    
}

- (IBAction)tijiaoBtnAction:(id)sender {
    if ([IsBlankString isBlankString:self.priceText.text] == NO) {
        if ([self.priceText.text floatValue] < [self.allPrice floatValue] * 0.95) {
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"修改价格不能低于%0.2f元!", [self.allPrice floatValue] * 0.95]];
        } else {
            if ([self.priceText.text floatValue] > [self.allPrice floatValue]) {
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"修改价格不能高于%0.2f元!", [self.allPrice floatValue]]];
            } else {
                self.block(self.priceText.text);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
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
