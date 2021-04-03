//
//  ShoppingCartViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "ShoppingCartViewController.h"

@interface ShoppingCartViewController ()

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
    [rightButton setTitle:@"清空" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _arrayListResult = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - StatusRect - NavRect - 65)];
    _tableView.backgroundColor = [UIColor blackColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    _shoppingCartListBottomView = [[NSBundle mainBundle] loadNibNamed:@"ShoppingCartListBottomView" owner:nil options:nil][0];
    _shoppingCartListBottomView.frame = CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height, kDeviceWidth, 65);
    [self.view addSubview:_shoppingCartListBottomView];
    
    [_shoppingCartListBottomView.jisuanBtn addTarget:self action:@selector(jisuanBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setListNet];
}

- (void)rightBtnAction {  // 清空购物车
    [self setDelete:@""];
}

- (void)setDelete:(NSString *)cartId {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    NSDictionary *dic = @{@"cartType":@"0"};
    NSString *url = emptyCartURL;
    if ([IsBlankString isBlankString:cartId] == NO) {
        dic = @{@"cartId":cartId};
        url= deleteCartProductURL;
    }
    [NetworkHandler requestPostWithUrl:url parameters:dic completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationReloadHomeTotal object:nil];
            [self setListNet];
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)jisuanBtnAction {
    [SettlementCheckStockNet setAddNet:self.view selfView:self];
}

- (void)loadNewData {
    [self setListNet];
}

//   每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayListResult.count;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ShoppingCartTableViewCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShoppingCartTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    
    ShoppingCartModel *shoppingCartModel = self.arrayListResult[indexPath.row];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入修改件数" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([IsBlankString isBlankString:self.count] == NO) {
//            shoppingCartModel.lmNumber = self.count;
//            [self.tableView reloadData];
            [self setAddNet:[NSString stringWithFormat:@"%@", shoppingCartModel.goodsId] count:self.count];
        }
    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入需要购买的件数";
        textField.delegate = self;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.text = [NSString stringWithFormat:@"%@", shoppingCartModel.lmNumber];
    }];
    [self presentViewController:alertController animated:true completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length > 3 && ![string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    self.count = textField.text;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
 
// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ShoppingCartModel *shoppingCartModel = self.arrayListResult[indexPath.row];
        [self setDelete:[NSString stringWithFormat:@"%@", shoppingCartModel.cartId]];
    }
}
 
// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)setListNet {  // 购物车列表

    [NetworkHandler requestPostWithUrl:productListURL parameters:@{@"cartType":@"0", @"page":@"1", @"limit":@"500", @"order":@"desc", @"sort":@"add_time"} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            self->_arrayListResult = [NSMutableArray array];
            
            NSArray *array = result[@"data"][@"list"];
            
            self.shoppingCartListBottomView.allPriceLabel.text = [NSString stringWithFormat:@"¥%@", result[@"data"][@"totalPrice"]];
            
            for (NSMutableDictionary *dic in array) {
                ShoppingCartModel*shoppingCartModel = [[ShoppingCartModel alloc] init];
                [shoppingCartModel setValuesForKeysWithDictionary:dic];
                [self.arrayListResult addObject:shoppingCartModel];
            }
            
            if (array.count > 0 || self.arrayListResult.count == 0) {
                [self.tableView reloadData];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setAddNet:(NSString *)goodsId count:(NSString *)count {  // 修改购物车内商品数量
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:updateCartProductURL parameters:@{@"goodsId":goodsId, @"cartType":@"0", @"productNumber":count} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationReloadHomeTotal object:nil];
            [self setListNet];
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
