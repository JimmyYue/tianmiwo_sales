//
//  MyViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"
#import "ResultsDetailViewController.h"
#import "OrderListViewController.h"
#import "PersonalInformationViewController.h"
#import "InventoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyViewController : BlackTopViewController

- (IBAction)empBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *idLabel;

@property (nonatomic,strong) CAGradientLayer *gradientLayer;

- (IBAction)orderListBtnAction:(id)sender;

- (IBAction)inventoryBtnAction:(id)sender;

- (IBAction)setBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *chengjiaoLabel;

@property (strong, nonatomic) IBOutlet UILabel *jineLabel;

@property (strong, nonatomic) IBOutlet UILabel *tichengLabel;


@end

NS_ASSUME_NONNULL_END
