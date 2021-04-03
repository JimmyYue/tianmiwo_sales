//
//  OrderListViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "MyOrderListTableViewCell.h"
#import "OrderListModel.h"
#import "MyOrderDetailsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewController : BlackTopViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) NSMutableArray *arrayList;
@property (nonatomic, strong) NSString *page;
@end

NS_ASSUME_NONNULL_END
