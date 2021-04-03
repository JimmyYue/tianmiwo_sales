//
//  OrderDetailListModel.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/14.
//

#import "OrderDetailListModel.h"

@implementation OrderDetailListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"picUrl"]){
        self.picUrl = value;
    }
    if ([key isEqualToString:@"goodsName"]){
        self.goodsName = value;
    }
    if ([key isEqualToString:@"specifications"]){
        self.specifications = value;
    }
    if ([key isEqualToString:@"productNumber"]){
        self.productNumber = value;
    }
    if ([key isEqualToString:@"retailPrice"]){
        self.retailPrice = value;
    }
}
@end
