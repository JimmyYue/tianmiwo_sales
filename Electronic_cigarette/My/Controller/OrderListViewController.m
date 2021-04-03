//
//  OrderListViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "OrderListViewController.h"

@interface OrderListViewController ()

@end

@implementation OrderListViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)wZNotificationOrderList:(NSNotification*)notification
{
    [self loadNewData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wZNotificationOrderList:)
                                                 name:WZNotificationOrderList
                                               object:nil];
    
    self.title = @"订单列表";
    self.view.backgroundColor = [UIColor blackColor];
    
    _arrayListResult = [[NSMutableArray alloc] init];
    _arrayList = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth - 20, kDeviceHeight - StatusRect - NavRect)];
    _tableView.backgroundColor = [UIColor blackColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    self.tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.page = @"1";
    [self setListNet];
}

- (void)loadNewData {
    self.page = @"1";
    [self setListNet];
}

- (void)loadMoreData {
    self.page = [NSString stringWithFormat:@"%lu", self.arrayListResult.count + 1];
    [self setListNet];
}

//设置表上有几个区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayListResult.count;
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
    static NSString *str = @"MyOrderListTableViewCell";
    MyOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyOrderListTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    OrderListModel *orderListModel = _arrayListResult[indexPath.section];
    
    if ([orderListModel.saleType intValue]  == 0) {
        cell.typeLabel.text = @"云仓出货";
        cell.typeView.image = IMAGENAMED(@"order_yuncang");
    } else {
        cell.typeLabel.text = @"线下出货";
        cell.typeView.image = IMAGENAMED(@"order_xianxia");
    }
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%@", orderListModel.saleSn];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", orderListModel.saleGoodsList[0][@"goodsName"]];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", orderListModel.actualPrice];
    
    cell.countLabel.text = [NSString stringWithFormat:@"共 %@ 件", orderListModel.totalCount];
    
    cell.statusLabel.text = [NSString stringWithFormat:@"%@", orderListModel.statusName];
    
    [cell.pImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", orderListModel.saleGoodsList[0][@"picUrl"]]] placeholderImage:[UIImage imageNamed:@"product_default"]];
    
    cell.timeLabel.text =  [NSString stringWithFormat:@"%@", orderListModel.addTimeFormat];
    
    cell.personnelNumberLabel.text =  [NSString stringWithFormat:@"销售员 : %@", orderListModel.sellerName];
    
    //  取消cell选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//此代码可以进入下一级菜单时点击单元格高亮消失
    MyOrderDetailsViewController *orderVC = [[MyOrderDetailsViewController alloc] init];
    orderVC.detailDic = self.arrayList[indexPath.section];
    orderVC.saleId = [NSString stringWithFormat:@"%@", self.arrayList[indexPath.section][@"saleId"]];
    [self.navigationController pushViewController:orderVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 178;
}


- (void)setListNet {

    [NetworkHandler requestPostWithUrl:saleListURL parameters:@{@"page":self.page, @"limit":@"20"} completion:^(id result) {
        
        NSLog(@"%@", result);
        
        if ([result[@"ok"] intValue] == 1) {
            
            if ([self->_page isEqualToString:@"1"]) {
                self->_arrayListResult = [NSMutableArray array];
                self.arrayList = [NSMutableArray array];
            }
            
            NSArray *array = result[@"data"][@"list"];
            
            for (NSMutableDictionary *dic in array) {
                OrderListModel*orderListModel = [[OrderListModel alloc] init];
                [orderListModel setValuesForKeysWithDictionary:dic];
                [self.arrayListResult addObject:orderListModel];
                [self.arrayList addObject:dic];
            }
            
            if (array.count > 0 || self.arrayListResult.count == 0) {
                [self.tableView reloadData];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
