//
//  SettlementViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "SettlementViewController.h"

@interface SettlementViewController ()

@end

@implementation SettlementViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wZNotificationScanning:)
                                                 name:WZNotificationScanning
                                               object:nil];
    
    self.title = @"结算";
    self.view.backgroundColor = [UIColor blackColor];
    
    _arrayListResult = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth - 20, kDeviceHeight - StatusRect - NavRect - 65)];
    _tableView.backgroundColor = [UIColor blackColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth - 20, 215)];
    self.tableHeaderView.backgroundColor = [UIColor blackColor];
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    _settlementHeardView = [[NSBundle mainBundle] loadNibNamed:@"SettlementHeardView" owner:nil options:nil][0];
    _settlementHeardView.selfView = self;
    self.settlementHeardView.frame = CGRectMake(-10, 0, kDeviceWidth, 215);
    _settlementHeardView.inventory = self.inventory;
    [self.tableHeaderView addSubview:self.settlementHeardView];
    
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 170)];
    self.tableFooterView.backgroundColor = [UIColor blackColor];
    self.tableView.tableFooterView = self.tableFooterView;
    
    _settlementFootView = [[NSBundle mainBundle] loadNibNamed:@"SettlementFootView" owner:nil options:nil][0];
    _settlementFootView.selfView = self;
    self.settlementFootView.frame = CGRectMake( -10, 0, kDeviceWidth, 160);
    [self.tableFooterView addSubview:self.settlementFootView];
    
    _settementBottomView = [[NSBundle mainBundle] loadNibNamed:@"SettementBottomView" owner:nil options:nil][0];
    _settementBottomView.selfView = self;
    _settementBottomView.frame = CGRectMake(0, kDeviceHeight - StatusRect - NavRect - 75, kDeviceWidth, 70);
    [self.view addSubview:_settementBottomView];
    
    [_settementBottomView.collectionBtn addTarget:self action:@selector(collectionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    if ([IsBlankString isBlankString:self.inventory] == NO) {  // 如果线下库存不足
        _settlementHeardView.chuhuoTypeLabel.text = @"云仓出货";
        _settlementHeardView.sendType = @"0";
        _settlementFootView.payTypeLabel.text = @"微信支付";
        _settlementFootView.payType = @"1";
    }
    
    [self setListNet];
}

//   每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayListResult.count;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ShoppingCartTableViewCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShoppingCartTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    cell.lineView.hidden = YES;
    cell.backView.hidden = YES;
    
    ShoppingCartModel*shoppingCartModel = self.arrayListResult[indexPath.row];
    
    [cell.goodImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", shoppingCartModel.picUrl]] placeholderImage:[UIImage imageNamed:@"product_default"]];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", shoppingCartModel.goodsName];
    cell.countLabel.text = [NSString stringWithFormat:@"门店 : %@", shoppingCartModel.offlineStock];
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", shoppingCartModel.price];
    cell.buyCountLabel.text = [NSString stringWithFormat:@"X%@", shoppingCartModel.lmNumber];
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)setListNet {  // 购物车列表

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:productListURL parameters:@{@"cartType":@"0", @"page":@"1", @"limit":@"500", @"order":@"desc", @"sort":@"add_time"} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            self.arrayListResult = [NSMutableArray array];
            
            self.array = result[@"data"][@"list"];
            
            self.settlementFootView.allPriceLabel.text = [NSString stringWithFormat:@"¥%@", result[@"data"][@"totalPrice"]];
            self.settementBottomView.allPrice = [NSString stringWithFormat:@"%@", result[@"data"][@"totalPrice"]];
            self.settementBottomView.settlementFootView = self.settlementFootView;
            
            for (NSMutableDictionary *dic in self.array) {
                ShoppingCartModel*shoppingCartModel = [[ShoppingCartModel alloc] init];
                [shoppingCartModel setValuesForKeysWithDictionary:dic];
                [self.arrayListResult addObject:shoppingCartModel];
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

- (void)collectionBtnAction {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if ([IsBlankString isBlankString:_settlementHeardView.sendType] == NO) {
            [dic setObject:_settlementHeardView.sendType forKey:@"sendType"];  // 出货方式
            if ([IsBlankString isBlankString:_settlementHeardView.huiyuanText.text] == NO) {
                if ([XYCommon isMobileNumber:_settlementHeardView.huiyuanText.text] == NO) {
                    [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号码!"];
                } else {
                    [dic setObject:_settlementHeardView.huiyuanText.text forKey:@"buyerPhone"];  // 会员
                    if ([IsBlankString isBlankString:_settlementHeardView.addressId] == NO) {
                        [dic setObject:_settlementHeardView.addressId forKey:@"addressId"];  // 地址
                        if ([IsBlankString isBlankString:_settlementFootView.payType] == NO) {
                            [dic setObject:_settlementFootView.payType forKey:@"payType"];  // 支付方式
                            
                            [dic setObject:[_settlementFootView.allPriceLabel.text substringFromIndex:1] forKey:@"goodPrice"];  // 商品价格
                            if ([_settlementFootView.shijiLabel.text isEqualToString:@"¥0"]) {
                                [dic setObject:[_settlementFootView.allPriceLabel.text substringFromIndex:1] forKey:@"factPrice"];  // 实付金额
                            } else {
                                [dic setObject:[_settlementFootView.shijiLabel.text substringFromIndex:1] forKey:@"factPrice"];  // 实付金额
                            }
                            
                            NSMutableArray *array = [[NSMutableArray alloc] init];
                            for (NSDictionary *dic in self.array) {
                                NSMutableDictionary *dicS = [NSMutableDictionary dictionaryWithDictionary:dic];
                                [dicS setObject:dic[@"specificationsName"] forKey:@"specifications"];
                                [array addObject:dicS];
                            }
                            [dic setObject:array forKey:@"goodDetailsList"];  // 商品列表
                            
                            [self setAddSaleNet:dic];
                            
                        } else {
                            [SVProgressHUD showInfoWithStatus:@"请选择支付方式!"];
                        }
                    } else {
                        [SVProgressHUD showInfoWithStatus:@"请选择收货地址!"];
                    }
                }
            } else {
                [SVProgressHUD showInfoWithStatus:@"请填写会员手机号码!"];
            }
        } else {
            [SVProgressHUD showInfoWithStatus:@"请选择出货方式!"];
        }
}

- (void)setAddSaleNet:(NSMutableDictionary *)dic {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:addSaleURL parameters:dic completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            self.tradeNo = [NSString stringWithFormat:@"%@", result[@"data"]];
            
            [ScanningModel setScanning:self];
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)wZNotificationScanning:(NSNotification*)notification
{
    bool push = false;
    NSArray *temArray = self.navigationController.viewControllers;
    for(UIViewController *temVC in temArray) {
        if ([temVC isKindOfClass:[PayWaitForViewController class]]) {
            push = true;
            break;
        }
    }
    if (push == false) {
        PayWaitForViewController *payVC = [[PayWaitForViewController alloc] init];
        payVC.tradeNo = self.tradeNo;
        payVC.authCode = [NSString stringWithFormat:@"%@", notification.userInfo[@"scanning"]];
        [self.navigationController pushViewController:payVC animated:YES];
    }
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
