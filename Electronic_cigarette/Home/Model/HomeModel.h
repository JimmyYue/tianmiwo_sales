//
//  HomeModel.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *retailPrice;
@property (nonatomic, strong) NSString *offlineStock;
@property (nonatomic, strong) NSString *url;
@end

NS_ASSUME_NONNULL_END
