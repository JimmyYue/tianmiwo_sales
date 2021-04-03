//
//  LogisticsDetailViewController.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import "LogisticsDetailViewController.h"

@interface LogisticsDetailViewController ()

@end

@implementation LogisticsDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单状态";
    self.view.backgroundColor = [UIColor colorWithHexString:@"F5F7FA"];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth, 44)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *topNunberLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, kDeviceWidth - 32, 44)];
    topNunberLabel.font = [UIFont systemFontOfSize:17];
    topNunberLabel.text = [NSString stringWithFormat:@"订单编号 : %@", _detailDic[@"saleSn"]];
    [topView addSubview:topNunberLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, kDeviceWidth, kDeviceHeight - StatusRect - NavRect - 55)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

//   每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

//  cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"OrderStateFTableViewCell";
    OrderStateFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderStateFTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    
    cell.stateLabel.text = @[@"待支付", @"待交货", @"已出货", @"已收货", @"已完成"][indexPath.row];
    cell.nowStateTitleLabel.text = @[@"待支付", @"待交货", @"已出货", @"已收货", @"已完成"][indexPath.row];
    
    if (indexPath.row < [self.detailDic[@"saleStatus"] integerValue]) {
        cell.stateLabel.hidden = YES;
        cell.nowImageView.hidden = NO;
        cell.nowStateTitleLabel.hidden = NO;
        cell.nowTimeLabel.hidden = NO;
        cell.lineTopView.backgroundColor = [UIColor redColor];
        cell.lineBottomView.backgroundColor = [UIColor redColor];
    }
    
    if (indexPath.row == 0) {
        cell.lineTopView.hidden = YES;
        cell.nowTimeLabel.text = [NSString stringWithFormat:@"%@", _detailDic[@"addTimeFormat"]];
    }
    else if (indexPath.row == 1) {
        cell.nowTimeLabel.text = [NSString stringWithFormat:@"%@", _detailDic[@"payTimeFormat"]];
    }
    else if (indexPath.row == 2) {
        cell.nowTimeLabel.text = [NSString stringWithFormat:@"%@", _detailDic[@"shipTimeFormat"]];
    }
    else if (indexPath.row == 3) {
        cell.nowTimeLabel.text = [NSString stringWithFormat:@"%@", _detailDic[@"confirmTimeFormat"]];
    }
    else if (indexPath.row == 4) {
        cell.nowTimeLabel.text = [NSString stringWithFormat:@"%@", _detailDic[@"endTimeFormat"]];
        cell.lineBottomView.hidden = YES;
    }
    
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
    return 80;
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
