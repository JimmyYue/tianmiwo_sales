//
//  SettlementViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartTableViewCell.h"
#import "SettlementHeardView.h"
#import "SettlementFootView.h"
#import "SettementBottomView.h"
#import "ShoppingCartModel.h"
#import "ScanningModel.h"
#import "PayWaitForViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettlementViewController : BlackTopViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *tableFooterView;
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) SettlementHeardView *settlementHeardView;
@property (nonatomic, strong) SettlementFootView *settlementFootView;
@property (nonatomic, strong) SettementBottomView *settementBottomView;
@property (nonatomic, strong) NSString *inventory;  // 判断库存是否充足
@property (nonatomic, strong) NSString *tradeNo; // 订单号
@end

NS_ASSUME_NONNULL_END
