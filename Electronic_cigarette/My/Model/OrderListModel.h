//
//  OrderListModel.h
//  YueKe
//
//  Created by JimmyYue on 2021/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListModel : NSObject

@property (nonatomic, strong) NSString *storeName;  // 门店
@property (nonatomic, strong) NSString *longitude; 
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSArray *saleGoodsList;  // 产品列表
@property (nonatomic, strong) NSString *addTimeFormat;  // 下单时间
@property (nonatomic, strong) NSString *actualPrice; // 付款金额
@property (nonatomic, strong) NSString *saleStatus;  // 订单状态
@property (nonatomic, strong) NSString *statusName;
@property (nonatomic, strong) NSString *totalCount;  // 购买总数
@property (nonatomic, strong) NSString *saleId; // id
@property (nonatomic, strong) NSString *saleSn; // 订单编号
@property (nonatomic, strong) NSString *saleType; // 出货
@property (nonatomic, strong) NSString *sellerName; // 销售员

@end

NS_ASSUME_NONNULL_END
