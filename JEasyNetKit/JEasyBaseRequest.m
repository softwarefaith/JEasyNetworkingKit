//
//  JEasyBaseRequest.m
//  JEasyNetWorkDemo
//
//  Created by 蔡杰 on 2017/5/4.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import "JEasyBaseRequest.h"
#import "JEasyNetworkConfig.h"


@implementation JEasyBaseRequest

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark -请求
- (NSMutableURLRequest *)request{
    return nil;
}

-(JEasyHTTPMethodType)requestMethod{
    return kJEasyHTTPMethodGET;
}

-(NSString *)url{
    NSString *server = [[self server] length]>0? [self server]:[JEasyNetworkConfig sharedConfig].server;
    return [NSString stringWithFormat:@"%@%@",server,[self api]];
}

-(NSString *)server{
    return nil;
}

-(NSString *)api{
    return nil;
}

-(JEasyRequestSerializerType)requestSerializerType{
    return kJEasyRequestSerializerJSON;
}

-(NSDictionary<NSString *,NSString *> *)headers{
    return nil;
}

-(NSDictionary<NSString *,id> *)parameters{
    return nil;
}

-(NSArray *)requestAuthorizationHeaderFieldArray{
    return nil;
}

-(NSTimeInterval)timeoutInterval{
    return 60.0f;
}

-(NSURLRequestCachePolicy)requestCachePolicy{
    return NSURLRequestUseProtocolCachePolicy;
}

-(NSURLSessionConfiguration *)requestConfiguration{
    return nil;
}

#pragma mark -response
-(JEasyResponseSerializerType)responseSerializerType{
    return kJEasyResponseSerializerJSON;
}
- (nullable NSSet *)responseAcceptableContentTypes {
    return [NSSet setWithObjects:
            @"text/json",
            @"text/html",
            @"application/json",
            @"text/javascript", nil];
}
#pragma mark - 回调
-(void)completeWithRequest:(JEasyBaseRequest *)request{
    return;
}
#pragma mark - 截断
- (void)requestWillStart:(id _Nonnull)request{
    return;
}

- (void)requestDidStop:(id _Nonnull)request{
    return;
}



@end
