//
//  SettlementHeardView.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "ShippingAddressViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettlementHeardView : UIView

- (IBAction)chuhuoBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *chuhuoTypeLabel;

@property (strong, nonatomic) IBOutlet UITextField *huiyuanText;

- (IBAction)shouhuoBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *shouhuoLabel;

@property (nonatomic,strong) UIViewController *selfView;

@property (nonatomic, strong) NSString *inventory;

@property (nonatomic, strong) NSString *sendType;  // 出货方式
@property (nonatomic, strong) NSString *addressId;  // 地址

@end

NS_ASSUME_NONNULL_END
