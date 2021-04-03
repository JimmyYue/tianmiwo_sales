//
//  HomeModel.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/31.
//

#import "HomeModel.h"

@implementation HomeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"goodsId"]){
        self.goodsId = value;
    }
    if ([key isEqualToString:@"goodsName"]){
        self.goodsName = value;
    }
    if ([key isEqualToString:@"retailPrice"]){
        self.retailPrice = value;
    }
    if ([key isEqualToString:@"offlineStock"]){
        self.offlineStock = value;
    }
    if ([key isEqualToString:@"url"]){
        self.url = value;
    }
}
@end
