//
//  MyOrderDetailsViewController.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import "MyOrderDetailsViewController.h"

@interface MyOrderDetailsViewController ()

@end

@implementation MyOrderDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}

- (void)headerRefreshing {
    self.resultArray = [NSMutableArray array];
    [self setDetailNet];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)wZNotificationScanning:(NSNotification*)notification
{
    PayWaitForViewController *payVC = [[PayWaitForViewController alloc] init];
    payVC.tradeNo = [NSString stringWithFormat:@"%@", self.detailDic[@"saleSn"]];
    payVC.authCode = [NSString stringWithFormat:@"%@", notification.userInfo[@"scanning"]];
    [self.navigationController pushViewController:payVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wZNotificationScanning:)
                                                 name:WZNotificationScanning
                                               object:nil];

    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, StatusRect + NavRect)];
    statusView.backgroundColor = [UIColor colorWithHexString:@"a116a1"];
    [self.view addSubview:statusView];
    
    [statusView.layer insertSublayer:self.gradientLayerN atIndex:0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth / 4, StatusRect + (NavRect - 20) / 2, kDeviceWidth / 2, 20)];
    titleLabel.text = @"订单详情";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    [statusView addSubview:titleLabel];
    
    UIButton *agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, StatusRect + (NavRect - 40) / 2, 40, 40)];
    [agreeBtn setImage:IMAGENAMED(@"public_imageBack") forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(fagreeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [statusView addSubview:agreeBtn];
    
    self.resultArray = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusRect + NavRect, kDeviceWidth, kDeviceHeight - StatusRect - NavRect)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
//    _tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    
    self.tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 175)];
    self.tableView.tableHeaderView = self.tableViewHeaderView;

    _orderDetailView = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailView" owner:nil options:nil][0];
    _orderDetailView.frame = CGRectMake(0, 0, kDeviceWidth, 175);
    _orderDetailView.selfView = self;
    _orderDetailView.detailDic = _detailDic;
    [self.tableViewHeaderView addSubview:_orderDetailView];
    

    _orderDetailView.stateLabel.text = [NSString stringWithFormat:@"%@", _detailDic[@"statusName"]];
    NSLog(@"%@", self.detailDic[@"saleStatus"]);
    NSString *imageStr = @[@"order_daizhifu", @"order_daifahuo", @"order_yichuhuo", @"order_yishouhuo", @"order_yishouhuo"][[self.detailDic[@"saleStatus"] integerValue] - 1];
    _orderDetailView.stateImageView.image = IMAGENAMED(imageStr);
    _orderDetailView.numberLabel.text = [NSString stringWithFormat:@"%@", _detailDic[@"statusDesc"]];

    float height = 240;
    if ([self.detailDic[@"saleStatus"] integerValue] == 1) {
        height = 310;
    }
    if ([self.detailDic[@"saleType"] integerValue] == 0) {
        if ([self.detailDic[@"saleStatus"] integerValue] == 1) {
            height = 550;
        } else {
            height = 470;
        }
    }
    self.tableViewFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, height)];
    self.tableView.tableFooterView = self.tableViewFooterView;
    
    if ([self.detailDic[@"saleStatus"] integerValue] == 1) {
        UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth - 110, height - 60, 100, 50)];
        payBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [payBtn setTitle:@"支付" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        payBtn.backgroundColor = [UIColor blackColor];
        payBtn.layer.cornerRadius = 25.0f;
        [payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.tableViewFooterView addSubview:payBtn];
        
        [payBtn.layer insertSublayer:self.gradientLayer atIndex:0];
    }

    _orderDetailBottomFView = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailBottomFView" owner:nil options:nil][0];
    _orderDetailBottomFView.frame = CGRectMake(0, 0, kDeviceWidth, 240);
    [self.tableViewFooterView addSubview:_orderDetailBottomFView];

    _orderDetailBottomFView.priceLabel.text = [NSString stringWithFormat:@"¥%@",  _detailDic[@"actualPrice"]];

    _orderDetailBottomFView.numberLabel.text = [NSString stringWithFormat:@"%@", self.detailDic[@"saleSn"]];
    NSInteger index = [self.detailDic[@"payId"] integerValue];
    _orderDetailBottomFView.payTypeLabel.text = [NSString stringWithFormat:@"%@", @[@"微信", @"支付宝", @"银行卡", @"现金"][index]];
    _orderDetailBottomFView.timeLabel.text = [NSString stringWithFormat:@"%@", self.detailDic[@"addTimeFormat"]];

    if ([self.detailDic[@"saleType"] integerValue] == 0) {
        
        _orderDetailBottomSView = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailBottomSView" owner:nil options:nil][0];
        _orderDetailBottomSView.frame = CGRectMake(0, 240, kDeviceWidth, 230);
        [self.tableViewFooterView addSubview:_orderDetailBottomSView];

        _orderDetailBottomSView.fahuoTimeLabel.text = [NSString stringWithFormat:@"%@", self.detailDic[@"shipTimeFormat"]];
        _orderDetailBottomSView.shouhuoLabel.text = [NSString stringWithFormat:@"%@", self.detailDic[@"consignee"]];
        _orderDetailBottomSView.phoneLabel.text = [NSString stringWithFormat:@"%@", self.detailDic[@"mobile"]];
        _orderDetailBottomSView.addressLabel.text = [NSString stringWithFormat:@"%@", self.detailDic[@"address"]];

    }
    
    [self setDetailNet];
}

- (void)fagreeBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)payBtnAction {
    
    [ScanningModel setScanning:self];
    
}

//   每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ShoppingCartTableViewCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShoppingCartTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    OrderDetailListModel*orderDetailListModel = _resultArray[indexPath.row];
    
    [cell.goodImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", orderDetailListModel.picUrl]] placeholderImage:[UIImage imageNamed:@"product_default"]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", orderDetailListModel.goodsName];
    cell.countLabel.text = [NSString stringWithFormat:@"%@", orderDetailListModel.specifications];
    
    cell.buyCountLabel.text = [NSString stringWithFormat:@"x %@", orderDetailListModel.productNumber];

    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", orderDetailListModel.retailPrice];
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)setDetailNet {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];

    [NetworkHandler requestPostWithUrl:saleInfoURL parameters:@{@"saleId":self.saleId} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            NSArray *array = result[@"data"];
            
            for (NSMutableDictionary *dic in array) {
                OrderDetailListModel*orderDetailListModel = [[OrderDetailListModel alloc] init];
                [orderDetailListModel setValuesForKeysWithDictionary:dic];
                [self->_resultArray addObject:orderDetailListModel];
            }
            
            [self.tableView reloadData];
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, 100, 50);
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:89/255.0 green:190/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:83/255.0 green:39/255.0 blue:200/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayer = gl;
        gl.cornerRadius = 25.0;
    }
    return _gradientLayer;
}

- (CAGradientLayer *)gradientLayerN {
    if (_gradientLayerN == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, kDeviceWidth, StatusRect + NavRect);
        gl.startPoint = CGPointMake(-0.01, -0.06);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:184/255.0 green:17/255.0 blue:167/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:155/255.0 green:20/255.0 blue:161/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayerN = gl;
    }
    return _gradientLayerN;
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
