//
//  AppDelegate.h
//  Electronic_cigarette
//
//  Created by JimmyYue on 2021/3/29.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <UserNotifications/UserNotifications.h>
#import <UMPush/UMessage.h>             // Push组件
#import <UMCommon/UMCommon.h>
#import <UserNotifications/UserNotifications.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

