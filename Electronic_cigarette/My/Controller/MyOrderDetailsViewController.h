//
//  MyOrderDetailsViewController.h
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartTableViewCell.h"
#import "OrderDetailView.h"
#import "OrderDetailBottomFView.h"
#import "OrderDetailBottomSView.h"
#import "LogisticsDetailViewController.h"
#import "OrderDetailListModel.h"
#import "ScanningModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderDetailsViewController : BlackTopViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *saleId;
@property (nonatomic, strong) NSDictionary *detailDic;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) UIView *tableViewHeaderView;
@property (nonatomic, strong) UIView *tableViewFooterView;
@property (nonatomic, strong) OrderDetailView *orderDetailView;
@property (nonatomic, strong) OrderDetailBottomFView *orderDetailBottomFView;
@property (nonatomic, strong) OrderDetailBottomSView *orderDetailBottomSView;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (nonatomic,strong) CAGradientLayer *gradientLayerN;
@end

NS_ASSUME_NONNULL_END
