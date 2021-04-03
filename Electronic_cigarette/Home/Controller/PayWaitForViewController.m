//
//  PayWaitForViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/4/1.
//

#import "PayWaitForViewController.h"
#import "UIImage+GIF.h"
#import "OrderListViewController.h"

@interface PayWaitForViewController ()

@end

@implementation PayWaitForViewController

- (void)wZNotificationScanning:(NSNotification*)notification
{
    self.authCode = [NSString stringWithFormat:@"%@", notification.userInfo[@"scanning"]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pay_loading" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    self.statusImage.image = [UIImage sd_imageWithGIFData:gifData];
    self.loadingLabel.text = @"正在支付中请稍等...";
    [self setPayNet];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)back
{
    bool push = false;
    NSArray *temArray = self.navigationController.viewControllers;
    for(UIViewController *temVC in temArray) {
        if ([temVC isKindOfClass:[OrderListViewController class]]) {
            push = true;
            break;
        }
    }
    if (push == true) {
        [self.navigationController popToViewController:temArray[2] animated:YES];
    } else {
        NSArray *temArray = self.navigationController.viewControllers;
        if (temArray.count > 1) {
            [self.navigationController popToViewController:temArray[1] animated:YES];
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wZNotificationScanning:)
                                                 name:WZNotificationScanning
                                               object:nil];
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"public_imageBack"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.title = @"支付中";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.payBtn.layer insertSublayer:self.gradientLayer atIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pay_loading" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    self.statusImage.image = [UIImage sd_imageWithGIFData:gifData];
    
    [self setPayNet];
}

- (void)setPayNet {
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    if (uuid.length > 32) {
        uuid = [uuid substringToIndex:32];
    }
   
    [NetworkHandler requestPostWithUrl:payURL parameters:@{@"deviceNo":uuid, @"authCode":self.authCode, @"tradeNo":self.tradeNo} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            if ([result[@"data"][@"code"] intValue] == 0) {
                
                self.statusImage.image = IMAGENAMED(@"pay_successful");
                self.payBtn.hidden = YES;
                self.loadingLabel.text = @"支付成功";
                [self setDelete];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationOrderList object:nil];
                
                [self setQueryOrder];
            } else {
                self.statusImage.image = IMAGENAMED(@"pay_failure");
                self.loadingLabel.text = @"支付失败";
                self.payBtn.hidden = NO;
                [SVProgressHUD showInfoWithStatus:result[@"data"][@"message"]];
            }
            
        } else {
            self.statusImage.image = IMAGENAMED(@"pay_failure");
            self.loadingLabel.text = @"支付失败";
            self.payBtn.hidden = NO;
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
    } failure:^(NSError *error) {
    }];
}




- (IBAction)payBtnAction:(id)sender {
    [ScanningModel setScanning:self];
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

- (void)setQueryOrder {
    [NetworkHandler requestPostWithUrl:queryOrderURL parameters:@{@"tradeNo":self.tradeNo} completion:^(id result) {
        if ([result[@"ok"] intValue] == 1) {
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
    } failure:^(NSError *error) {
    }];
}

- (void)setDelete {
    [NetworkHandler requestPostWithUrl:emptyCartURL parameters:@{@"cartType":@"0"} completion:^(id result) {
        if ([result[@"ok"] intValue] == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationReloadHomeTotal object:nil];
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
    } failure:^(NSError *error) {
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
