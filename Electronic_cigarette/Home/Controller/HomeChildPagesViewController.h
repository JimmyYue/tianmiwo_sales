//
//  HomeChildPagesViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"
#import "HomeCollectionViewCell.h"
#import "HomeFooterView.h"
#import "GoodsDetailsViewController.h"
#import "HomeModel.h"
#import "AddGoodNet.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeChildPagesViewController : UIViewController <ZJScrollPageViewChildVcDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) NSString *page;
@property (strong, nonatomic) NSString *categoryId;
@property (strong, nonatomic) IBOutlet UICollectionView *HomeCollectionView;

@end

NS_ASSUME_NONNULL_END
