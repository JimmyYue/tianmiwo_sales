//
//  LogisticsDetailViewController.h
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import <UIKit/UIKit.h>
#import "OrderStateFTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogisticsDetailViewController : BlackTopViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSDictionary *detailDic;
@property (nonatomic, strong) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
