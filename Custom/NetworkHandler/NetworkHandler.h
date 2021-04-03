//
//  NetworkHandler.h
//  WangYiNews
//
//  Created by JimmyYue on 3/29/15.
//

#import <Foundation/Foundation.h>
#import "LogViewController.h"

@interface NetworkHandler : NSObject
+ (void)requestPostWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic completion:(void (^)(id result))block failure:(void (^)(NSError *error))failure;
+ (void)requestGetWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic completion:(void (^)(id result))block failure:(void (^)(NSError *error))failure;
@end
