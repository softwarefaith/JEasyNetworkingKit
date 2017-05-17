//
//  JEasyBaseRequest.h
//  JEasyNetWorkDemo
//
//  Created by 蔡杰 on 2017/5/4.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 HTTP methods enum for JEasyRequest.
 */
typedef NS_ENUM(NSInteger, JEasyHTTPMethodType) {
    kJEasyHTTPMethodGET    = 0,    //!< GET
    kJEasyHTTPMethodPOST   = 1,    //!< POST
    kJEasyHTTPMethodHEAD   = 2,    //!< HEAD
    kJEasyHTTPMethodDELETE = 3,    //!< DELETE
    kJEasyHTTPMethodPUT    = 4,    //!< PUT
    kJEasyHTTPMethodPATCH  = 5,    //!< PATCH
};

/**
 Resquest parameter serialization type enum for JEasyRequest, see `AFURLRequestSerialization.h` for details.
 */
typedef NS_ENUM(NSInteger, JEasyRequestSerializerType) {
    kJEasyRequestSerializerRAW     = 0,
    kJEasyRequestSerializerJSON    = 1,
    kJEasyRequestSerializerPlist   = 2,
};

/**
 Response data serialization type enum for JEasyRequest, see `AFURLResponseSerialization.h` for details.
 */
typedef NS_ENUM(NSInteger, JEasyResponseSerializerType) {
    kJEasyResponseSerializerRAW    = 0,
    kJEasyResponseSerializerJSON   = 1,
    kJEasyResponseSerializerPlist  = 2,
    kJEasyResponseSerializerJEasyXML    = 3,
};


typedef NS_ENUM(NSInteger, JEasyRequestState){
    JEasyRequestStateReady = 0,
    JEasyRequestStateStarted,
    JEasyRequestStateResponseAvailableFromCache,
    JEasyRequestStateStaleResponseAvailableFromCache,
    JEasyRequestStateCancelled,
    JEasyRequestStateCompleted,
    JEasyRequestStateError
};

@class JEasyBaseRequest;

NS_ASSUME_NONNULL_BEGIN


typedef void (^JEasyHandler)(JEasyBaseRequest* completedRequest,NSError * _Nullable error);

@interface JEasyBaseRequest : NSObject {
    
    JEasyRequestState _state;
}

/**

 @return only mark
 */
- (NSString *)identifier;


@property (nonatomic,readonly,assign) JEasyRequestState state;

#pragma mark -请求

/**
   parent class  depend on (requestMethod url headers parameters)
    @return    custmer request
 */
- (NSMutableURLRequest *)request;

- (JEasyHTTPMethodType)requestMethod;

- (NSString *)url;

- (NSString *)server;

- (NSString *)api;

- (JEasyRequestSerializerType)requestSerializerType;

- (NSDictionary<NSString *,NSString *> *)headers;

- (NSDictionary<NSString *, id> *)parameters;

// 请求的Server用户名和密码
- (NSArray *)requestAuthorizationHeaderFieldArray;

- (NSTimeInterval)timeoutInterval;


@property (nonatomic, assign) BOOL useGeneralHeaders;
@property (nonatomic, assign) BOOL useGeneralParameters;

/**
 *  HTTP 请求的Cache策略
 *  @default
 *   NSURLRequestUseProtocolCachePolicy
 *
 *  @return NSURLRequestCachePolicy
 */
- (NSURLRequestCachePolicy)requestCachePolicy;

- (NSURLSessionConfiguration *)requestConfiguration;


/**
   失败后 是否重新请求  
    @default 0
 */
@property (nonatomic, assign) NSUInteger retryCount;

#pragma mark - 响应

@property (nonatomic, assign) JEasyResponseSerializerType responseSerializerType;

@property (nonatomic, strong, readonly) NSURLSessionTask *task;

- (nullable NSSet *)responseAcceptableContentTypes;

#pragma mark -回调

@property (nonatomic,copy)JEasyHandler comletedHandler;

- (void)completeWithRequest:(JEasyBaseRequest *)request;

#pragma mark - 截断函数
@property (nonatomic, copy, nullable) void (^requestWillStartBlock)(id _Nonnull);

@property (nonatomic, copy, nullable) void (^requestDidStopBlock)(id _Nonnull);

- (void)requestWillStart:(id _Nonnull)request;

- (void)requestDidStop:(id _Nonnull)request;

@end

@interface JEasyBaseRequest (JEasyProcess)

- (void) start;

- (void) cancel;

@end

NS_ASSUME_NONNULL_END

