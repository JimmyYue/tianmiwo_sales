//
//  OrderListModel.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/13.
//

#import "OrderListModel.h"

@implementation OrderListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"storeName"]){
        self.storeName = value;
    }
    if ([key isEqualToString:@"saleGoodsList"]){
        self.saleGoodsList = value;
    }
    if ([key isEqualToString:@"addTimeFormat"]){
        self.addTimeFormat = value;
    }
    if ([key isEqualToString:@"actualPrice"]){
        self.actualPrice = value;
    }
    if ([key isEqualToString:@"saleStatus"]){
        self.saleStatus = value;
    }
    if ([key isEqualToString:@"totalCount"]){
        self.totalCount = value;
    }
    if ([key isEqualToString:@"saleId"]){
        self.saleId = value;
    }
    if ([key isEqualToString:@"longitude"]){
        self.longitude = value;
    }
    if ([key isEqualToString:@"latitude"]){
        self.latitude = value;
    }
    if ([key isEqualToString:@"statusName"]){
        self.statusName = value;
    }
    if ([key isEqualToString:@"saleSn"]){
        self.saleSn = value;
    }
    if ([key isEqualToString:@"saleType"]){
        self.saleType = value;
    }
    if ([key isEqualToString:@"sellerName"]){
        self.sellerName = value;
    }
    
}
@end
