//
//  OrderStateFTableViewCell.h
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderStateFTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *dianView;
@property (strong, nonatomic) IBOutlet UIView *lineTopView;
@property (strong, nonatomic) IBOutlet UIView *lineBottomView;
@property (strong, nonatomic) IBOutlet UIImageView *nowImageView;

@property (strong, nonatomic) IBOutlet UILabel *stateLabel;

@property (strong, nonatomic) IBOutlet UILabel *nowStateTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *nowTimeLabel;



@end

NS_ASSUME_NONNULL_END
