//
//  CitySelectorView.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import <UIKit/UIKit.h>
#import "HBLocationModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ResultBlock)(HBLocationModel * _Nullable province, HBLocationModel * _Nullable city, HBLocationModel * _Nullable area);

@interface CitySelectorView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, copy) ResultBlock selectResultBlock;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)cancelBtnAction:(id)sender;

- (IBAction)sureBtnAction:(id)sender;

@property (nonatomic, strong) NSArray * provinceList;
@property (nonatomic, strong) NSArray * cityList;
@property (nonatomic, strong) NSArray * areaList;
@property(strong,nonatomic) HBLocationModel *selectProvince;
@property(strong,nonatomic) HBLocationModel *selectCity;
@property(strong,nonatomic) HBLocationModel *selectArea;

+ (instancetype)pickerView;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
