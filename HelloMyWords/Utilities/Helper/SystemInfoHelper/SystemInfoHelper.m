//
//  SystemInfoHelper.m
//  HSWordsPass
//
//  Created by yang on 14-9-2.
//  Copyright (c) 2014年 yang. All rights reserved.
//

#import "SystemInfoHelper.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "sys/utsname.h"

NSString *productID()
{
    NSString *prefix = @"LiveCourse";
    NSString *sufix  = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? @"_iOS_iPhone" : @"_iOS_iPad";
    
    NSString *productID = [NSString stringWithFormat:@"%@%@", prefix, sufix];
    return productID;
}

NSString *currentLanguage()
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defs objectForKey:@"AppleLanguages"];
    NSString *preferredLan = [languages objectAtIndex:0];
    
    return preferredLan;
}

NSString *timeStamp()
{
    NSDate* nowDate = [NSDate date];
    NSUInteger stamp = [nowDate timeIntervalSince1970];
    NSString *strTimeStamp = [[NSString alloc] initWithFormat:@"%@", @(stamp)];
    return strTimeStamp;
}

NSString *device()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    /*
    NSString *sysname = [NSString stringWithCString:systemInfo.sysname encoding:NSUTF8StringEncoding];
    NSString *nodename = [NSString stringWithCString:systemInfo.nodename encoding:NSUTF8StringEncoding];
    NSString *release = [NSString stringWithCString:systemInfo.release encoding:NSUTF8StringEncoding];
    NSString *version = [NSString stringWithCString:systemInfo.version encoding:NSUTF8StringEncoding];
    */
    NSString *device = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //NSLog(@"sysname: %@; nodename: %@; release: %@; version: %@; device: %@", sysname, nodename, release, version, device);
    
    return device;
}

NSString *deviceVersion()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *version = [NSString stringWithCString:systemInfo.release encoding:NSUTF8StringEncoding];
    return version;
}

#define USER_APP_PATH                 @"/User/Applications/"
BOOL isJailBreak()
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH]) {
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:USER_APP_PATH error:nil];
        NSLog(@"applist = %@", applist);
        return YES;
    }
    return NO;
}

