//
//  OrderDetailView.h
//  YueKe
//
//  Created by JimmyYue on 2021/3/12.
//

#import <UIKit/UIKit.h>
#import "LogisticsDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailView : UIView
@property (nonatomic, strong) NSDictionary *detailDic;
@property (nonatomic, strong) UIViewController *selfView;

@property (strong, nonatomic) IBOutlet UIView *backview;

@property (strong, nonatomic) IBOutlet UIView *pushView;

@property (nonatomic,strong) CAGradientLayer *gradientLayer;

@property (strong, nonatomic) IBOutlet UILabel *stateLabel;

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@property (strong, nonatomic) IBOutlet UIImageView *stateImageView;

- (IBAction)backBtnAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
