//
//  JEasyNetworkEngine.h
//  JEasyNetWorkDemo
//
//  Created by 蔡杰 on 2017/5/4.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JEasyBaseRequest;

@interface JEasyNetworkEngine : NSObject

/**
 *  发送API请求
 */
- (void)sendAPIRequest:(nonnull JEasyBaseRequest  *)api;

/**
 *  取消API请求
 */
- (void)cancelAPIRequest:(nonnull JEasyBaseRequest  *)api;

@end
