//
//  ShippingAddressModel.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShippingAddressModel : NSObject
@property (nonatomic, strong) NSString *addressDetail;
@property (nonatomic, strong) NSString *addressId;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *receiver;
@property (nonatomic, strong) NSString *receiverPhone;
@end

NS_ASSUME_NONNULL_END
