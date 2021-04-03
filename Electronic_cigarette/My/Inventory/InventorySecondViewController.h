//
//  InventorySecondViewController.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/4/1.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"
#import "HomeCollectionViewCell.h"
#import "GoodsDetailsViewController.h"
#import "HomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface InventorySecondViewController : UIViewController <ZJScrollPageViewChildVcDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *arrayListResult;
@property (nonatomic, strong) NSString *page;
@property (strong, nonatomic) NSString *categoryId;

@property (strong, nonatomic) IBOutlet UICollectionView *HomeCollectionView;

@end

NS_ASSUME_NONNULL_END
