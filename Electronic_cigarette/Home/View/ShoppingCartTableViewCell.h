//
//  ShoppingCartTableViewCell.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UIView *lineView;

@property (strong, nonatomic) IBOutlet UIImageView *goodImg;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UILabel *buyCountLabel;




@end

NS_ASSUME_NONNULL_END
