//
//  JEasyNetworkConfig.h
//  JEasyNetWorkDemo
//
//  Created by 蔡杰 on 2017/5/8.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface JEasyNetworkConfig : NSObject

+(instancetype)sharedConfig;

@property(nonatomic,copy) NSString *server;

@property(nonatomic,readonly,copy) NSMutableDictionary *commonHeaders;

@property(nonatomic,readonly,copy) NSMutableDictionary *commonParamers;

-(void)addRequestHeradersWithDictionary:(NSDictionary *_Nonnull)headers;

-(void)addRequestParamersWithDictionary:(NSDictionary *_Nonnull)paramers;

@end

NS_ASSUME_NONNULL_END
