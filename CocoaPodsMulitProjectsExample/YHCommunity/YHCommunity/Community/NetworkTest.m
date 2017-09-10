//
//  NetworkTest.m
//  YHCommunity
//
//  Created by ShannonChen on 2017/3/18.
//  Copyright © 2017年 ShannonChen. All rights reserved.
//

#import "NetworkTest.h"
#import <YHLogger.h>
#import <AFNetworking.h>

@implementation NetworkTest

- (void)test {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
#ifdef HTTP
    [YHLogger log:@"====Start Monitoring===="];
    [manager stopMonitoring];
    [YHLogger log:@"====Stop Monitoring===="];
    
#endif

}


@end
