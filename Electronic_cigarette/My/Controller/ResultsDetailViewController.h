//
//  ResultsDetailViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "ZHLineChartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultsDetailViewController : BlackTopViewController

@property (strong, nonatomic) IBOutlet UIView *fView;
@property (nonatomic,strong) CAGradientLayer *gradientLayerF;

@property (strong, nonatomic) IBOutlet UIView *sView;
@property (nonatomic,strong) CAGradientLayer *gradientLayerS;

@property (strong, nonatomic) IBOutlet UIView *tView;
@property (nonatomic,strong) CAGradientLayer *gradientLayerT;

@property (strong, nonatomic) IBOutlet UILabel *tichengLabel;

@property (strong, nonatomic) IBOutlet UILabel *dingdanLabel;

@property (strong, nonatomic) IBOutlet UILabel *jineLabel;

@property (strong, nonatomic) IBOutlet UIButton *fTimeBtn;
- (IBAction)fTimeBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *sTimeBtn;
- (IBAction)sTimeBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *typeBtn;
- (IBAction)typeBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *tichengHidden;
@property (strong, nonatomic) IBOutlet UIImageView *tichengImgHidden;


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZHLineChartView *zHLineChartView;

@property (nonatomic, strong) NSString *timeRange;
@property (nonatomic, strong) NSString *timeRangeZ;
@property (nonatomic, strong) NSString *dimension;
@end

NS_ASSUME_NONNULL_END
