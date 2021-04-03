//
//  CitySelectorView.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "CitySelectorView.h"

@implementation CitySelectorView

- (IBAction)sureBtnAction:(id)sender {
    if (self.selectResultBlock) {
        self.selectResultBlock(self.selectProvince, self.selectCity, self.selectArea);
    }
    [self dismiss];
}

- (IBAction)cancelBtnAction:(id)sender {
    [self dismiss];
}

+ (instancetype)pickerView
{
    CitySelectorView * addressPickerView = [[[NSBundle mainBundle] loadNibNamed:@"CitySelectorView" owner:nil options:nil] firstObject];
    addressPickerView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    return addressPickerView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupPickerViewUI];
    [self setCity];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)setupPickerViewUI
{
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

#pragma mark -------- <UIPickerViewDataSource, UIPickerViewDelegate>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        //省
        return self.provinceList.count;
    } else if (component == 1){
        //市
        return self.cityList.count;
    } else {
        // 区县
        return self.areaList.count;
    }
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray * list = nil;
    if (component == 0) {
        //省
        list = self.provinceList;
    } else if (component == 1){
        //市
        list = self.cityList;
    } else {
        list = self.areaList;
    }
    HBLocationModel * model = list[row];
    return model.name;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray * list = nil;
    if (component == 0) {
        //省
        list = self.provinceList;
    } else if (component == 1){
        //市
        list = self.cityList;
    } else {
        list = self.areaList;
    }
    HBLocationModel * model = list[row];
    
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:model.name attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1], NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    
    return attributeString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        //省
        self.selectProvince = self.provinceList[row];
        //查出市的数据
        self.cityList = self.selectProvince.list;
        if (self.cityList.count) {
            self.selectCity = self.cityList[0];
        }
        //查出区的数据
        HBLocationModel * firstCity = self.cityList.firstObject;
        self.areaList = firstCity.list;
        if (self.areaList.count) {
            self.selectArea = self.areaList[0];
        } else {
            HBLocationModel * none = [[HBLocationModel alloc] init];
            none.name = @"";
            none.code = @"";
            self.selectArea = none;
        }
        [self.pickerView reloadComponent:1];
        [self.pickerView reloadComponent:2];
    } else if (component == 1){
        //市
        if (self.cityList.count) {
            self.selectCity = self.cityList[row];
        }
        self.areaList = self.selectCity.list;
        [self.pickerView reloadComponent:2];
    } else {
        //区
        self.selectArea = self.areaList[row];
    }
}

- (void)setCity {

    [NetworkHandler requestGetWithUrl:regionURL parameters:nil completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            NSMutableArray * list = [NSMutableArray array];
            for (NSDictionary * provinceDict in result[@"data"][@"list"]) {
                HBLocationModel * province = [[HBLocationModel alloc] initWithJsonData:provinceDict];
                [list addObject:province];
            }
            self.provinceList = [list copy];

            if ([self.provinceList count]) {
                HBLocationModel * first = [self.provinceList firstObject];
                self.cityList = first.list;
            }
            if (self.cityList.count) {
                HBLocationModel * first = [self.cityList firstObject];
                self.areaList = first.list;
            }
            [self.pickerView reloadAllComponents];
            
            // 默认数据
            self.selectProvince = self.provinceList.firstObject;
            self.selectCity = self.cityList.firstObject;
            self.selectArea = self.areaList.firstObject;
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
