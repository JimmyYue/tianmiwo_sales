//
//  ShippingAddressViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "ShippingAddressViewController.h"

@interface ShippingAddressViewController ()

@end

@implementation ShippingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择地址";
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
    [rightButton setTitle:@"新增" forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _arrayListResult = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth - 20, kDeviceHeight - StatusRect - NavRect)];
    _tableView.backgroundColor = [UIColor blackColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self setListNet];
}

- (void)rightBtnAction {
    AddAddressViewController *addVC = [[AddAddressViewController alloc] init];
    addVC.memberPhone = self.memberPhone;
    [addVC setBlock:^(NSString * _Nonnull reload) {
        [self setListNet];
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}

//设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayListResult.count;
}

//   每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//  分区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

//  去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] init];
    viewHeader.backgroundColor = [UIColor blackColor];
    return viewHeader;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ShippingAddressTableViewCell";
    ShippingAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShippingAddressTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    ShippingAddressModel*shippingAddressModel = self.arrayListResult[indexPath.section];
    cell.nameLabel.text = [NSString  stringWithFormat:@"%@", shippingAddressModel.receiver];
    cell.phoneLabel.text = [NSString  stringWithFormat:@"%@", shippingAddressModel.receiverPhone];
    cell.addressLabel.text = [NSString  stringWithFormat:@"%@%@%@%@", shippingAddressModel.provinceName, shippingAddressModel.cityName, shippingAddressModel.countryName, shippingAddressModel.addressDetail];
    
    cell.eitBtn.tag = 500 + indexPath.section;
    [cell.eitBtn addTarget:self action:@selector(exitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)exitBtnAction:(UIButton *)button {
    ShippingAddressModel*shippingAddressModel = self.arrayListResult[button.tag - 500];
    AddAddressViewController *addVC = [[AddAddressViewController alloc] init];
    addVC.shippingAddressModel = shippingAddressModel;
    addVC.memberPhone = self.memberPhone;
    [addVC setBlock:^(NSString * _Nonnull reload) {
        [self setListNet];
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    ShippingAddressModel*shippingAddressModel = self.arrayListResult[indexPath.section];
    self.block(shippingAddressModel);
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)setListNet {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    _arrayListResult = [NSMutableArray array];
    
    [NetworkHandler requestPostWithUrl:addressListURL parameters:@{@"phone":self.memberPhone} completion:^(id result) {
        
        NSLog(@"%@", result);
        
        if ([result[@"ok"] intValue] == 1) {
            
            NSArray *array = result[@"data"];

            for (NSMutableDictionary *dic in array) {
                ShippingAddressModel*shippingAddressModel = [[ShippingAddressModel alloc] init];
                [shippingAddressModel setValuesForKeysWithDictionary:dic];
                [self.arrayListResult addObject:shippingAddressModel];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
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
