//
//  IsBlankString.m
//  KuFangWuYou
//
//  Created by JimmyYue on 2017/6/15.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "IsBlankString.h"

@implementation IsBlankString

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
