//
//  ShoppingCartModel.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/31.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"goodsId"]){
        self.goodsId = value;
    }
    if ([key isEqualToString:@"goodsName"]){
        self.goodsName = value;
    }
    if ([key isEqualToString:@"picUrl"]){
        self.picUrl = value;
    }
    if ([key isEqualToString:@"offlineStock"]){
        self.offlineStock = value;
    }
    if ([key isEqualToString:@"price"]){
        self.price = value;
    }
    if ([key isEqualToString:@"lmNumber"]){
        self.lmNumber = value;
    }
    if ([key isEqualToString:@"cartId"]){
        self.cartId = value;
    }
}
@end
