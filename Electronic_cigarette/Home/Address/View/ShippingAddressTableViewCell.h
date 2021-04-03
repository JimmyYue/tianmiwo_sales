//
//  ShippingAddressTableViewCell.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShippingAddressTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *eitBtn;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;



@end

NS_ASSUME_NONNULL_END
