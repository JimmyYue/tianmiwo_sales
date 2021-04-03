//
//  ShippingAddressModel.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/4/1.
//

#import "ShippingAddressModel.h"

@implementation ShippingAddressModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"addressDetail"]){
        self.addressDetail = value;
    }
    if ([key isEqualToString:@"addressId"]){
        self.addressId = value;
    }
    if ([key isEqualToString:@"city"]){
        self.city = value;
    }
    if ([key isEqualToString:@"cityName"]){
        self.cityName = value;
    }
    if ([key isEqualToString:@"country"]){
        self.country = value;
    }
    if ([key isEqualToString:@"countryName"]){
        self.countryName = value;
    }
    if ([key isEqualToString:@"province"]){
        self.province = value;
    }
    if ([key isEqualToString:@"provinceName"]){
        self.provinceName = value;
    }
    if ([key isEqualToString:@"receiver"]){
        self.receiver = value;
    }
    if ([key isEqualToString:@"receiverPhone"]){
        self.receiverPhone = value;
    }
}
@end
