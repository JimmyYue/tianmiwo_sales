//
//  MyViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", [XYCommon GetUserDefault:@"NickName"]];
    self.idLabel.text = [NSString stringWithFormat:@"销售ID : %@", [XYCommon GetUserDefault:@"Phone"]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.backView.layer insertSublayer:self.gradientLayer atIndex:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSelectTimeViewBuy)];
        [self.backView addGestureRecognizer:tap];
    
    [self setDataNet];
}

- (IBAction)empBtnAction:(id)sender {
    PersonalInformationViewController *empVC = [[PersonalInformationViewController alloc] init];
    [self.navigationController pushViewController:empVC animated:YES];
}

- (void)dismissSelectTimeViewBuy {
    ResultsDetailViewController *resultVC = [[ResultsDetailViewController alloc] init];
    [self.navigationController pushViewController:resultVC animated:YES];
}

- (IBAction)setBtnAction:(id)sender {
    SettingViewController *setVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (IBAction)inventoryBtnAction:(id)sender {
    InventoryViewController *inVC = [[InventoryViewController alloc] init];
    [self.navigationController pushViewController:inVC animated:YES];
}

- (IBAction)orderListBtnAction:(id)sender {
    OrderListViewController *orderVC = [[OrderListViewController alloc] init];
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, kDeviceWidth - 20, 95);
        gl.startPoint = CGPointMake(0.03, 0.2);
        gl.endPoint = CGPointMake(0.99, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:217/255.0 green:12/255.0 blue:147/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:23/255.0 green:21/255.0 blue:183/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayer = gl;
        gl.cornerRadius = 10.0;
    }
    return _gradientLayer;
}


- (void)setDataNet {
    
    [NetworkHandler requestPostWithUrl:statisticsURL parameters:nil completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"data"][@"dealCount"]]] == NO) {
                self.chengjiaoLabel.text = [NSString stringWithFormat:@"%@", result[@"data"][@"dealCount"]];
            }
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"data"][@"dealAmount"]]] == NO) {
                self.jineLabel.text = [NSString stringWithFormat:@"%@", result[@"data"][@"dealAmount"]];
            }
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"data"][@"commission"]]] == NO) {
                self.tichengLabel.text = [NSString stringWithFormat:@"%@", result[@"data"][@"commission"]];
            }
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
