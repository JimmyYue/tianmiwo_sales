//
//  DetailHeaderView.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/10.
//

#import "DetailHeaderView.h"

@implementation DetailHeaderView

- (void)setDetaAllowView:(NSDictionary *)dic {

    self.goodsId = [NSString stringWithFormat:@"%@", dic[@"goods"][@"id"]];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth) delegate:self placeholderImage:[UIImage imageNamed:@"product_default"]];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//    _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
//    _cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    _cycleScrollView.autoScrollTimeInterval = 4.0;
//    _cycleScrollView.showPageControl = NO;
    [self addSubview:_cycleScrollView];
    
    _cycleScrollView.imageURLStringsGroup = dic[@"roundPicList"];
    
    UIView *allView = [[UIView alloc] initWithFrame:CGRectMake(10, kDeviceWidth - 40, kDeviceWidth - 20, kDeviceWidth)];
    allView.layer.cornerRadius = 15;
    allView.backgroundColor = [UIColor whiteColor];
    [self addSubview:allView];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10, 20, kDeviceWidth - 40, 33);
    titleLabel.text = [NSString stringWithFormat:@"%@", dic[@"goods"][@"lmName"]];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    titleLabel.numberOfLines = 2;
    [allView addSubview:titleLabel];

    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.frame = CGRectMake(10, titleLabel.frame.origin.y + titleLabel.frame.size.height + 10, kDeviceWidth - 40, 24);
    priceLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    priceLabel.text = [NSString stringWithFormat:@"¥%@", dic[@"goods"][@"retailPrice"]];
    priceLabel.textColor = [UIColor colorWithHexString:@"CF2353"];
    [allView addSubview:priceLabel];
    
    if (![self.type isEqualToString:@"detail"]) {
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth - 70, priceLabel.frame.origin.y - 5, 40, 40)];
        [addBtn setImage:IMAGENAMED(@"home_add") forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [allView addSubview:addBtn];
    }
    
    NSArray *arraySpecificationList = dic[@"specificationList"];
    
    if ([arraySpecificationList count] > 0) {
        
        NSString * string = @"";
        if ([arraySpecificationList count] > 0) {
            string = [NSString stringWithFormat:@"%@ : %@", dic[@"specificationList"][0][@"specification"], dic[@"specificationList"][0][@"lmValue"]];
        }
        for (int i = 0; i < [arraySpecificationList count]; i++) {
            if (i > 0) {
                string = [NSString stringWithFormat:@"%@\n%@ : %@", string, dic[@"specificationList"][i][@"specification"], dic[@"specificationList"][i][@"lmValue"]];
            }
        }
        
        NSMutableAttributedString *attContentStr = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange range = {0,[attContentStr length]};
        [attContentStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];
        [attContentStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
        
        CGSize attSize = [attContentStr boundingRectWithSize:CGSizeMake(kDeviceWidth - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        
        _packagingView = [[UILabel alloc] initWithFrame:CGRectMake(10, priceLabel.frame.origin.y + priceLabel.frame.size.height + 20, kDeviceWidth - 40, attSize.height + 37)];
        _packagingView.backgroundColor = [UIColor whiteColor];
        _packagingView.layer.cornerRadius = 8;
        _packagingView.layer.borderWidth = 1;
        _packagingView.layer.borderColor = [UIColor colorWithHexString:@"EBEBEB"].CGColor;
        [allView addSubview:_packagingView];
        
        UILabel *conLabel = [[UILabel alloc] init];
        conLabel.frame = CGRectMake(10, 16, kDeviceWidth - 60, attSize.height + 5);
        conLabel.numberOfLines = 0;
        conLabel.textColor = [UIColor colorWithHexString:@"FF808080"];
        conLabel.attributedText = attContentStr;
        [_packagingView addSubview:conLabel];
    }
    
    NSArray *arrayAttributeList = dic[@"attributeList"];
   
    if ([arrayAttributeList count] > 0) {
        
        NSString * stringS = @"";
        if ([arrayAttributeList count] > 0) {
            stringS = [NSString stringWithFormat:@"%@ : %@", dic[@"attributeList"][0][@"attribute"], dic[@"attributeList"][0][@"lmValue"]];
        }
        for (int i = 0; i < [arrayAttributeList count]; i++) {
            if (i > 0) {
                stringS = [NSString stringWithFormat:@"%@\n%@ : %@", stringS, dic[@"attributeList"][i][@"attribute"], dic[@"attributeList"][i][@"lmValue"]];
            }
        }

        NSMutableAttributedString *attContentStrS = [[NSMutableAttributedString alloc] initWithString:stringS];
        NSRange rangeS = {0,[attContentStrS length]};
        [attContentStrS addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:rangeS];
        NSMutableParagraphStyle *paragraphStyleS = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyleS setLineSpacing:6];
        [attContentStrS addAttribute:NSParagraphStyleAttributeName value:paragraphStyleS range:NSMakeRange(0, [stringS length])];

        CGSize attSizeS = [attContentStrS boundingRectWithSize:CGSizeMake(kDeviceWidth - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;

        _canshuView = [[UILabel alloc] initWithFrame:CGRectMake(10, _packagingView.frame.origin.y + _packagingView.frame.size.height + 20, kDeviceWidth - 40, attSizeS.height + 30)];
        _canshuView.backgroundColor = [UIColor whiteColor];
        _canshuView.layer.cornerRadius = 8;
        _canshuView.layer.borderWidth = 1;
        _canshuView.layer.borderColor = [UIColor colorWithHexString:@"EBEBEB"].CGColor;
        [allView addSubview:_canshuView];
        
        UILabel *parameterLabelS = [[UILabel alloc] init];
        parameterLabelS.frame = CGRectMake(10, 10, kDeviceWidth - 60, attSizeS.height + 5);
        parameterLabelS.numberOfLines = 0;
        parameterLabelS.textColor = [UIColor colorWithHexString:@"FF808080"];
        parameterLabelS.attributedText = attContentStrS;
        [_canshuView addSubview:parameterLabelS];
    }
    
    if ([arrayAttributeList count] > 0) {
        if ((_canshuView.frame.origin.y + _canshuView.frame.size.height + 120) < kDeviceHeight) {
            allView.frame = CGRectMake(10, _cycleScrollView.frame.origin.y + _cycleScrollView.frame.size.height - 40, kDeviceWidth - 20, kDeviceHeight - allView.frame.origin.y);
        } else {
            allView.frame = CGRectMake(10, _cycleScrollView.frame.origin.y + _cycleScrollView.frame.size.height - 40, kDeviceWidth - 20, _canshuView.frame.origin.y + _canshuView.frame.size.height + 120);
        }
    } else {
        if ((_packagingView.frame.origin.y + _packagingView.frame.size.height + 120) < kDeviceHeight) {
            allView.frame = CGRectMake(10, _cycleScrollView.frame.origin.y + _cycleScrollView.frame.size.height - 40, kDeviceWidth - 20, kDeviceHeight - allView.frame.origin.y);
        } else {
        allView.frame = CGRectMake(10, _cycleScrollView.frame.origin.y + _cycleScrollView.frame.size.height - 40, kDeviceWidth - 20, _packagingView.frame.origin.y + _packagingView.frame.size.height + 120);
        }
    }
    
    self.blockHeight(allView.frame.origin.y + allView.frame.size.height);
}

- (void)addBtnAction {
    [AddGoodNet setAddNet:self.goodsId view:self.view];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    ImageViewDetailView *imagePreview = [[ImageViewDetailView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
//    imagePreview.backgroundColor = [UIColor blackColor];
//
//    imagePreview.fileURLString = _cycleScrollView.imageURLStringsGroup[index];
//    [imagePreview setAllowView];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
