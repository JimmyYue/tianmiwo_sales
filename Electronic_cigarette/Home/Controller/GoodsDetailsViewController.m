//
//  GoodsDetailsViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "GoodsDetailsViewController.h"

@interface GoodsDetailsViewController ()

@end

@implementation GoodsDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    _scrollView.bounces = NO;
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];

    [self setListProductNetDetail];
    
    if (![self.type isEqualToString:@"detail"]) {
        _bottomCartView = [[NSBundle mainBundle] loadNibNamed:@"BottomCartView" owner:nil options:nil][0];
        self.bottomCartView.frame = CGRectMake(10, kDeviceHeight - 75, kDeviceWidth - 20, 58);
        self.bottomCartView.selfView = self;
        self.bottomCartView.view = self.view;
        self.bottomCartView.layer.borderWidth = 0.5f;
        self.bottomCartView.layer.borderColor = [UIColor colorWithHexString:@"ffffff" alpha:0.4].CGColor;
        [self.view addSubview:self.bottomCartView];
    }

    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth - 60, 50, 40, 40)];
    [rightButton setImage:IMAGENAMED(@"home_close") forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
}

- (void)rightBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setListProductNetDetail {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:goodsDetailURL parameters:@{@"goodsId":[NSNumber numberWithInt:[_goodsId intValue]]} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            self->_detailView = [[DetailHeaderView alloc] init];
            self->_detailView.type = self.type;
            self->_detailView.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
            self->_detailView.view = self.view;
            __weak typeof(self) weakSelf = self;
            [self->_detailView setBlockHeight:^(float height) {
                if (height < kDeviceHeight - 70) {
                    weakSelf.scrollView.contentSize = CGSizeMake(0, kDeviceHeight);
                    weakSelf.detailView.frame = CGRectMake(0, - StatusRect, kDeviceWidth, kDeviceHeight);
                } else {
                    weakSelf.scrollView.contentSize = CGSizeMake(0, height + 20);
                    weakSelf.detailView.frame = CGRectMake(0, -StatusRect, kDeviceWidth, height + StatusRect);
                }
                [weakSelf.scrollView addSubview:weakSelf.detailView];
            }];
            [self->_detailView setDetaAllowView:result[@"data"]];
            
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

@end
