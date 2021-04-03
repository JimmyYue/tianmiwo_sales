//
//  OrderDetailListModel.h
//  YueKe
//
//  Created by JimmyYue on 2021/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailListModel : NSObject

@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *goodsName;  // 产品
@property (nonatomic, strong) NSString *specifications;
@property (nonatomic, strong) NSString *productNumber;
@property (nonatomic, strong) NSArray *retailPrice;  // 价格

@end

NS_ASSUME_NONNULL_END
