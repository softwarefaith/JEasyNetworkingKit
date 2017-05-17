//
//  JEasyNetworkEngine.m
//  JEasyNetWorkDemo
//
//  Created by 蔡杰 on 2017/5/4.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import "JEasyNetworkEngine.h"
#import "JEasyBaseRequest.m"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <objc/runtime.h>

static dispatch_queue_t JEasy_task_creation_queue() {
    static dispatch_queue_t task_creation_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        task_creation_queue =
        dispatch_queue_create("JEasy.task.creation", DISPATCH_QUEUE_SERIAL);
    });
    return task_creation_queue;
}


@implementation JEasyNetworkEngine

+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
#pragma mark -Public
-(void)sendAPIRequest:(JEasyBaseRequest *)api{
    
    dispatch_async(JEasy_task_creation_queue(), ^{
        
        AFHTTPSessionManager *sessionManager = [self sessionManagerWithAPI:api];
        if (!sessionManager) {
            return;
        }
        [self sendSingleAPIRequest:api withSessionManager:sessionManager];

    });
}

- (void)cancelAPIRequest:(JEasyBaseRequest *)request{
    
}

#pragma mark - Private
- (void)sendSingleAPIRequest:(JEasyBaseRequest *)api withSessionManager:(AFHTTPSessionManager *)sessionManager {
}


#pragma mark --sessionManager
- (AFHTTPSessionManager *)sessionManagerWithAPI:(JEasyBaseRequest *)api {

    AFHTTPRequestSerializer *requestSerializer = [self requestSerializerForAPI:api];
    if (!requestSerializer) {
        // Serializer Error, just return;
        return nil;
    }
    
    // Response Part
    AFHTTPResponseSerializer *responseSerializer = [self responseSerializerForAPI:api];
    
    //NSString *baseUrlStr = [self ];
    // AFHTTPSession
    AFHTTPSessionManager *sessionManager;
   // sessionManager = [self.sessionManagerCache objectForKey:baseUrlStr];
//    if (!sessionManager) {
//        sessionManager = [self newSessionManagerWithBaseUrlStr:baseUrlStr];
//        [self.sessionManagerCache setObject:sessionManager forKey:baseUrlStr];
//    }
    
    sessionManager.requestSerializer     = requestSerializer;
    sessionManager.responseSerializer    = responseSerializer;
  //  sessionManager.securityPolicy        = [self securityPolicyWithAPI:api];
    
    return sessionManager;
}
#pragma mark --requestSerializer

- (AFHTTPRequestSerializer *)requestSerializerForAPI:(JEasyBaseRequest *)api {
    NSParameterAssert(api);
    
    AFHTTPRequestSerializer *requestSerializer;
    
    switch ([api requestSerializerType]) {
        case kJEasyRequestSerializerRAW:{
            requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        case kJEasyRequestSerializerJSON:{
            requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        }
        case kJEasyRequestSerializerPlist:{
            requestSerializer = [AFPropertyListRequestSerializer serializer];
            break;
        }
        default:{
            requestSerializer = [AFHTTPRequestSerializer serializer];
        }
            break;
    }
    
    requestSerializer.cachePolicy          = [api requestCachePolicy];
    requestSerializer.timeoutInterval      = [api timeoutInterval];
    NSDictionary *requestHeaderFieldParams = [api headers];
    
    if (requestHeaderFieldParams) {
        [requestHeaderFieldParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    return requestSerializer;
}

- (AFHTTPResponseSerializer *)responseSerializerForAPI:(JEasyBaseRequest *)api {
    NSParameterAssert(api);
    AFHTTPResponseSerializer *responseSerializer;
    
    switch ([api responseSerializerType]) {
        case kJEasyResponseSerializerRAW:
            responseSerializer = [AFHTTPResponseSerializer serializer];

            break;
        case kJEasyResponseSerializerJSON:{
             responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case kJEasyResponseSerializerPlist:{
             responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case kJEasyResponseSerializerJEasyXML:{
            responseSerializer = [AFXMLParserResponseSerializer serializer];

            break;
        }
            
        default:{
            responseSerializer = [AFHTTPResponseSerializer serializer];

        }
            break;
    }
    responseSerializer.acceptableContentTypes = [api responseAcceptableContentTypes];
    return responseSerializer;
}



@end
