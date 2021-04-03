//
//  NetworkHandler.m
//  WangYiNews
//

#import "NetworkHandler.h"
#import "AFHTTPSessionManager.h"

@implementation NetworkHandler
+ (void)requestPostWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic completion:(void (^)(id result))block failure:(void (^)(NSError *error))failure
{
//    NSDate *timeString = [NSDate date];//当前时间
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[timeString timeIntervalSince1970]];
    
    AFHTTPSessionManager *sessionPost = [AFHTTPSessionManager manager];
    sessionPost.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionPost.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionPost.responseSerializer = [AFJSONResponseSerializer serializer];
    [sessionPost.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"Token"]] == NO) {
        [sessionPost.requestSerializer setValue:[XYCommon GetUserDefault:@"Token"] forHTTPHeaderField:@"Tmw-Store-Token"];
    }
    
    [sessionPost POST:urlStr parameters:dic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            id result = responseObject;
            
//            if ([result[@"errno"] integerValue] == 501) {
//                [XYCommon SetUserDefault:@"Token" byValue:@""];
//                [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationNotLoggedIn object:nil];
//                UINavigationController *navigationController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//                LogViewController *logVC = [[LogViewController alloc] init];
//                logVC.modalPresentationStyle = 0;
//                [logVC setBlockLogin:^(BOOL login) {
//                    if (login == true) {
//                        [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationLoginSuccess object:nil];
//                    }
//                }];
//                [navigationController presentViewController:logVC animated:YES completion:nil];
//            }
            
            block(result);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
            NSLog(@"请求失败");
        }];
}


+ (void)requestGetWithUrl:(NSString *)urlStr parameters:(NSDictionary *)dic completion:(void (^)(id result))block failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *sessionGet = [AFHTTPSessionManager manager];
    sessionGet.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionGet.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionGet.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionGet.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",@"text/javascript",nil];
    [sessionGet.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"Token"]] == NO) {
        [sessionGet.requestSerializer setValue:[XYCommon GetUserDefault:@"Token"] forHTTPHeaderField:@"Tmw-Token"];
    }
    
    [sessionGet GET:urlStr parameters:dic headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
           
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
           id result = responseObject;
           
//           if ([result[@"errno"] integerValue] == 501) {
//               [XYCommon SetUserDefault:@"Token" byValue:@""];
//               [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationNotLoggedIn object:nil];
//               UINavigationController *navigationController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//               LogViewController *logVC = [[LogViewController alloc] init];
//               logVC.modalPresentationStyle = 0;
//               [logVC setBlockLogin:^(BOOL login) {
//                   if (login == true) {
//                       [[NSNotificationCenter defaultCenter] postNotificationName:WZNotificationLoginSuccess object:nil];
//                   }
//               }];
//               [navigationController presentViewController:logVC animated:YES completion:nil];
//           }
           
           block(result);
           
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           block(error);
           NSLog(@"请求失败");
       }];
}


@end
