//
//  AddAddressViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "CitySelectorView.h"
#import "ShippingAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddAddressViewController : BlackTopViewController

@property (strong, nonatomic) IBOutlet UITextField *shouhuoText;

@property (strong, nonatomic) IBOutlet UITextField *phoneText;

- (IBAction)areaBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *areaBtn;

@property (strong, nonatomic) IBOutlet UITextField *addressText;

- (IBAction)addBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;

@property (nonatomic,strong) CAGradientLayer *gradientLayer;

@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *provinceName;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *countryName;
@property (nonatomic, strong) NSString *memberPhone;
@property (nonatomic, strong) ShippingAddressModel*shippingAddressModel;
@property (nonatomic,copy)void (^block)(NSString *reload);
@end

NS_ASSUME_NONNULL_END
