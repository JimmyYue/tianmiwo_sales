//
//  ShoppingCartModel.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartModel : NSObject

@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *offlineStock;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *lmNumber;
@property (nonatomic, strong) NSString *cartId;

@end

NS_ASSUME_NONNULL_END
