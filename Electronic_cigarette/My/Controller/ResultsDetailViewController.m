//
//  ResultsDetailViewController.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/30.
//

#import "ResultsDetailViewController.h"

@interface ResultsDetailViewController ()

@end

@implementation ResultsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"业绩详情";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.fView.layer insertSublayer:self.gradientLayerF atIndex:0];
    [self.sView.layer insertSublayer:self.gradientLayerS atIndex:0];
    [self.tView.layer insertSublayer:self.gradientLayerT atIndex:0];
    
    if ([[XYCommon GetUserDefault:@"RoleId"] intValue] == 0) {
        self.tView.hidden = YES;
        self.tichengHidden.hidden = YES;
        self.tichengImgHidden.hidden = YES;
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 380, kDeviceWidth, 200)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, 0);
    _scrollView.bounces = NO;
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];
    
    [self.fTimeBtn setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    [self.sTimeBtn setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    [self.typeBtn setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    
    self.timeRange = @"0";
    [self setDataNet];
    
    self.dimension = @"0";
    self.timeRangeZ = @"7";
    [self setDataZNet];
    
}

- (void)setAllowLine:(float)width horizontalDataArr:(NSMutableArray *)horizontalDataArr lineDataAry:(NSMutableArray *)lineDataAry max:(NSNumber *)max {
    
    _zHLineChartView = [[ZHLineChartView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
    if ([max intValue] < 10) {
        _zHLineChartView.max = @10;
    } else {
        _zHLineChartView.max = max;
    }
    _zHLineChartView.min = @0;
    _zHLineChartView.backgroundColor = [UIColor clearColor];
    _zHLineChartView.horizontalDataArr = horizontalDataArr;
    _zHLineChartView.lineDataAry = lineDataAry;
    _zHLineChartView.splitCount = 2;
    _zHLineChartView.angle = 0;
    _zHLineChartView.bottomOffset = 10;
    _zHLineChartView.addCurve = NO;
    _zHLineChartView.textFontSize = 12;
    _zHLineChartView.edge = UIEdgeInsetsMake(25, 15, 30, 25);
    _zHLineChartView.lineColor = [UIColor colorWithHexString:@"00BDFF"];
    _zHLineChartView.circleFillColor = [UIColor colorWithHexString:@"00BDFF"];
    _zHLineChartView.colorArr = [NSArray arrayWithObjects:(id)[[[UIColor colorWithHexString:@"00BDFF"] colorWithAlphaComponent:0.4] CGColor],(id)[[[UIColor whiteColor] colorWithAlphaComponent:0.1] CGColor], nil];
    [self.scrollView addSubview:_zHLineChartView];
    [_zHLineChartView drawLineChart];
}

- (CAGradientLayer *)gradientLayerF {
    if (_gradientLayerF == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, kDeviceWidth - 48, 78);
        gl.startPoint = CGPointMake(-0.13, -0.58);
        gl.endPoint = CGPointMake(0.5, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:23/255.0 green:98/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:56/255.0 green:29/255.0 blue:182/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayerF = gl;
        gl.cornerRadius = 10.0;
    }
    return _gradientLayerF;
}

- (CAGradientLayer *)gradientLayerS {
    if (_gradientLayerS == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, kDeviceWidth - 48, 78);
        gl.startPoint = CGPointMake(-0.06, -0.43);
        gl.endPoint = CGPointMake(0.5, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:182/255.0 green:0/255.0 blue:255/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:107/255.0 green:26/255.0 blue:161/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayerS = gl;
        gl.cornerRadius = 10.0;
    }
    return _gradientLayerS;
}

- (CAGradientLayer *)gradientLayerT {
    if (_gradientLayerT == nil) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, kDeviceWidth - 48, 78);
        gl.startPoint = CGPointMake(0, -0.4);
        gl.endPoint = CGPointMake(0.5, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:252/255.0 green:0/255.0 blue:236/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:171/255.0 green:20/255.0 blue:154/255.0 alpha:1.0].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        _gradientLayerT = gl;
        gl.cornerRadius = 10.0;
    }
    return _gradientLayerT;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fTimeBtnAction:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"今天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.fTimeBtn setTitle:@"今天 " forState:UIControlStateNormal];
        self.timeRange = @"0";
        [self setDataNet];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"昨天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.fTimeBtn setTitle:@"昨天 " forState:UIControlStateNormal];
        self.timeRange = @"1";
        [self setDataNet];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"近7天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.fTimeBtn setTitle:@"近7天 " forState:UIControlStateNormal];
        self.timeRange = @"7";
        [self setDataNet];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"近30天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.fTimeBtn setTitle:@"近30天 " forState:UIControlStateNormal];
        self.timeRange = @"30";
        [self setDataNet];
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [actionSheet addAction:action4];
    [actionSheet addAction:action5];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)typeBtnAction:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"成交单数" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.typeBtn setTitle:@"成交单数 " forState:UIControlStateNormal];
        self.dimension = @"0";
        [self setDataZNet];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"成交金额" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.typeBtn setTitle:@"成交金额 " forState:UIControlStateNormal];
        self.dimension = @"1";
        [self setDataZNet];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"提成金额" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.typeBtn setTitle:@"提成金额 " forState:UIControlStateNormal];
        self.dimension = @"2";
        [self setDataZNet];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    if ([[XYCommon GetUserDefault:@"RoleId"] intValue] == 0) {
        [actionSheet addAction:action3];
    }
    [actionSheet addAction:action4];
    [self presentViewController:actionSheet animated:YES completion:nil];
}


- (IBAction)sTimeBtnAction:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"近7天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.sTimeBtn setTitle:@"近7天 " forState:UIControlStateNormal];
        self.timeRangeZ = @"7";
        [self setDataZNet];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"近30天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.sTimeBtn setTitle:@"近30天 " forState:UIControlStateNormal];
        self.timeRangeZ = @"30";
        [self setDataZNet];
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheet addAction:action3];
    [actionSheet addAction:action4];
    [actionSheet addAction:action5];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)setDataNet {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:rangeStatisticsURL parameters:@{@"timeRange":self.timeRange} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"data"][@"dealCount"]]] == NO) {
                self.dingdanLabel.text = [NSString stringWithFormat:@"%@", result[@"data"][@"dealCount"]];
            }
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"data"][@"dealAmount"]]] == NO) {
                self.jineLabel.text = [NSString stringWithFormat:@"%@", result[@"data"][@"dealAmount"]];
            }
            if ([IsBlankString isBlankString:[NSString stringWithFormat:@"%@", result[@"data"][@"commission"]]] == NO) {
                self.tichengLabel.text = [NSString stringWithFormat:@"%@", result[@"data"][@"commission"]];
            }
          
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


- (void)setDataZNet {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = [UIColor colorWithHexString:@"B4B4B4"];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    
    [NetworkHandler requestPostWithUrl:dailyStatisticsURL parameters:@{@"timeRange":self.timeRangeZ, @"dimension":self.dimension} completion:^(id result) {
        
        if ([result[@"ok"] intValue] == 1) {
            
            NSMutableArray *arrayCount = [[NSMutableArray alloc] init];
            NSMutableArray *arrayDay = [[NSMutableArray alloc] init];
            
            NSNumber *max = @0;
            for (NSNumber *count in result[@"data"][@"scoreList"]) {
                if ([max intValue] < [count intValue]) {
                    max = count;
                }
                [arrayCount addObject:count];
            }
            
            for (NSString *time in result[@"data"][@"dateList"]) {
                [arrayDay addObject:time];
            }
            
            if (self.zHLineChartView) {
                [self.zHLineChartView removeFromSuperview];
            }
            if ([self.timeRangeZ intValue] == 7) {
                self.scrollView.contentSize = CGSizeMake(kDeviceWidth, 0);
                [self setAllowLine:kDeviceWidth horizontalDataArr:arrayDay lineDataAry:arrayCount max:max];
            } else {
                self.scrollView.contentSize = CGSizeMake(kDeviceWidth * 4, 0);
                [self setAllowLine:kDeviceWidth * 4 horizontalDataArr:arrayDay lineDataAry:arrayCount max:max];
            }
            
        } else {
            [SVProgressHUD showInfoWithStatus:result[@"errmsg"]];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}




@end
