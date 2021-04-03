//
//  FeedbackViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"设置";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.tijiaoBtn.layer insertSublayer:self.gradientLayer atIndex:0];
    
    self.agreeText = [XBTextView textViewWithPlaceHolder:@"请填写您遇到的问题, 以便于我们更好的帮助您解决问题"];
    self.agreeText.frame = CGRectMake(15, 60, kDeviceWidth - 30, 140);
    self.agreeText.maxTextCount = 200;
    self.agreeText.textView.font = [UIFont systemFontOfSize:15];
    self.agreeText.textCountLabel.hidden = YES;
    [self.view addSubview:self.agreeText];
    
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

- (IBAction)tijiaoBtnAction:(id)sender {
    if ([IsBlankString isBlankString:self.agreeText.text] == NO) {
        [self setModifyPassword];
    } else {
        [SVProgressHUD showInfoWithStatus:@"请填写您的反馈内容!"];
    }
    
}

- (void)setModifyPassword {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:feedBackURL parameters:@{@"content":self.agreeText.text} completion:^(id result) {
        if ([result[@"ok"] intValue] == 1) {
            [SVProgressHUD showInfoWithStatus:@"您的反馈已提交!"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

@end
