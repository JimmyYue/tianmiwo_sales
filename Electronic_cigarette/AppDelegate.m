//
//  AppDelegate.m
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import "AppDelegate.h"
#import "LogViewController.h"
#import "HomeViewController.h"
#import "WZNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)) API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于前台时的远程推送接受
            //关闭U-Push自带的弹出框
            [UMessage setAutoAlert:NO];
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
            
        }else{
            [UMessage didReceiveRemoteNotification:userInfo];
          
        }
    } else {
        // Fallback on earlier versions
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    if (@available(iOS 10.0, *)) {
completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
    
}


//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];

    }else{
        //应用处于后台时的本地推送接受
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PGYKey];
    //启动基本SDKb
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGYKey];
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    
    [self setInspectionNetwork];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UIApplication sharedApplication]setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    [NSThread sleepForTimeInterval:1];
    
    //  友盟
    [UMConfigure initWithAppkey:UMKey channel:@"App Store"];

    // Push组件基本功能配置
       UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
       //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
       entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    } else {
        // Fallback on earlier versions
    }
       [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
           if (granted) {
               NSLog(@"%d", granted);
           }else{
           }
           NSLog(@"友盟error : %@", error);
       }];
    
    [UMConfigure setLogEnabled:YES];
    
    //  集成测试
    [UMConfigure deviceIDForIntegration];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    if (@available(iOS 13.0, *)) {
    } else {
        if ([IsBlankString isBlankString:[XYCommon GetUserDefault:@"Token"]] == NO) {
            HomeViewController *bindingVC = [[HomeViewController alloc] init];
            WZNavigationController *nav = [[WZNavigationController alloc] initWithRootViewController:bindingVC];
            self.window.rootViewController = nav;
        } else {
            LogViewController *bindingVC = [[LogViewController alloc] init];
            WZNavigationController *nav = [[WZNavigationController alloc] initWithRootViewController:bindingVC];
            self.window.rootViewController = nav;
        }
    }
    
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    
    if (![deviceToken isKindOfClass:[NSData class]]) return;
        const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
        NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                              ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                              ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                              ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
        NSLog(@"deviceToken : %@", hexToken);
    
        //1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
        //传入的devicetoken是系统回调didRegisterForRemoteNotificationsWithDeviceToken的入参，切记
        //[UMessage registerDeviceToken:deviceToken];
    
    [UMessage registerDeviceToken:deviceToken];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Electronic_cigarette"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

//  网络检查
- (void)setInspectionNetwork {
    
    //  单例方法创建监听对象
    AFNetworkReachabilityManager *reachabilityManger = [AFNetworkReachabilityManager sharedManager];
    //  开启网络监听
    [reachabilityManger startMonitoring];
    [reachabilityManger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                break;
            case AFNetworkReachabilityStatusNotReachable:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            default:
                break;
        }
    }];
}
@end
