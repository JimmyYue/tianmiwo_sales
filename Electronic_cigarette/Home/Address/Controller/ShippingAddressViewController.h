//
//  ShippingAddressViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "ShippingAddressTableViewCell.h"
#import "AddAddressViewController.h"
#import "ShippingAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShippingAddressViewController : BlackTopViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *memberPhone;
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,copy)void (^block)(ShippingAddressModel*shippingAddressModel);
@end

NS_ASSUME_NONNULL_END
