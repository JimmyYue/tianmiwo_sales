//
//  PhoneCall.m
//  YueKe
//
//  Created by JimmyYue on 2021/3/11.
//

#import "PhoneCall.h"

@implementation PhoneCall

+ (void)callPhoneNumber:(NSString*)number {
    NSString * phone = [NSString stringWithFormat:@"telprompt://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
}

@end
