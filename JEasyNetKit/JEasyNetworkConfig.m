//
//  JEasyNetworkConfig.m
//  JEasyNetWorkDemo
//
//  Created by 蔡杰 on 2017/5/8.
//  Copyright © 2017年 蔡杰. All rights reserved.
//

#import "JEasyNetworkConfig.h"

@interface JEasyNetworkConfig ()

@property(nonatomic,readwrite,copy) NSMutableDictionary *commonHeaders;

@property(nonatomic,readwrite,copy) NSMutableDictionary *commonParamers;

@end

@implementation JEasyNetworkConfig

+(instancetype)sharedConfig{
    
    static JEasyNetworkConfig *config = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        config = [[JEasyNetworkConfig alloc] init];
    });
    
    return config;
}

#pragma mark - Public
-(void)addRequestHeradersWithDictionary:(NSDictionary *)headers{
    [self.commonHeaders addEntriesFromDictionary:headers];
}

-(void)addRequestParamersWithDictionary:(NSDictionary *)paramers{
    [self.commonParamers addEntriesFromDictionary:paramers];
}


#pragma mark - Getter
-(NSMutableDictionary *)commonHeaders{
    if (_commonHeaders == nil) {
        _commonHeaders = [[NSMutableDictionary alloc] init];
    }
    return _commonHeaders;
}

-(NSMutableDictionary *)commonParamers{
    if (_commonParamers == nil) {
        _commonParamers = [[NSMutableDictionary alloc] init];
    }
    return _commonParamers;
}

@end
